# frozen_string_literal: true

require "ffi"


module Lummox::Core::SDL::Initialization
  extend FFI::Library

  ffi_lib FFI::CURRENT_PROCESS

  SUBSYSTEM_FLAGS = {
    timer:          0x00000001,
    audio:          0x00000010,
    video:          0x00000020,
    joystick:       0x00000200,
    haptic:         0x00001000,
    gamecontroller: 0x00002000,
    events:         0x00004000,
    sensor:         0x00008000
  }.freeze
  SUBSYSTEMS = SUBSYSTEM_FLAGS.keys.freeze

  def self.flags_from_subsystems(*subsystems)
    SUBSYSTEM_FLAGS.values_at(*subsystems).inject(:|)
  end
  private_class_method :flags_from_subsystems

  # TRICKY: Some subsystems depend on others, which they will automatically initalize. A comprehensive list at time of
  # this commit:
  # - gamecontroller initializes joystick, events
  # - joystick initializes events
  # - video initializes events
  # TODO: Implement SDL_WinRTRunApp?
  # TODO: Implement SDL_SetMainReady?
  attach_function :SDL_Init, [:uint32], :int
  attach_function :SDL_WasInit, [:uint32], :uint32
  private :SDL_Init, :SDL_WasInit
  private_class_method :SDL_Init, :SDL_WasInit

  attach_function :quit, :SDL_Quit, [], :void

  # Rubylike additions:
  class << self
    def init_subsystems
      initialized_flags = SDL_WasInit(0)
      SUBSYSTEM_FLAGS.filter { |_, flag| initialized_flags & flag == flag }.keys
    end

    def init?(*subsystems)
      flags = flags_from_subsystems(*subsystems)
      SDL_WasInit(flags) == flags
    end

    def init!(*subsystems)
      subsystems = Lummox::SDL::Core::Initialization::SUBSYSTEMS if subsystems.nil? || subsystems.empty?
      return if init?(*subsystems)

      flags = flags_from_subsystems(*subsystems)
      initialized_flags = SDL_WasInit(0)
      SDL_Init(flags ^ initialized_flags)
    end

    # TRICKY: Create helper methods to:
    # - determine whether particular subsytems were init (e.g. `audio_init?`)
    # - initialize particular subsytems if uninitialized (e.g. `audio_init!`)
    ::Lummox::Core::SDL::Initialization::SUBSYSTEMS.each do |subsystem|
      define_method(:"#{subsystem}_init?") { init?(subsystem) }
      define_method(:"#{subsystem}_init!") { init!(subsystem) }
    end
  end
end

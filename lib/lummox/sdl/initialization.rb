# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Initialization
  extend Lummox::SDL::Library

  # rubocop:disable Layout/HashAlignment
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
  # rubocop:enable Layout/HashAlignment
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
  attach_sdl_function :init, [:uint32], :int,        visibility: :private
  attach_sdl_function :was_init, [:uint32], :uint32, visibility: :private
  attach_sdl_function :quit, [], :void,              visibility: :private

  class << self
    def init!(*subsystems)
      subsystems = Lummox::SDL::Initialization::SUBSYSTEMS if subsystems.nil? || subsystems.empty?
      return if init?(*subsystems)

      flags = flags_from_subsystems(*subsystems)
      initialized_flags = was_init(0)
      success_code = init(flags ^ initialized_flags)
      Lummox::SDL::Error.raise_if { success_code.negative? }
    end

    def init?(*subsystems)
      flags = flags_from_subsystems(*subsystems)
      was_init(flags) == flags
    end

    # TRICKY: Create helper methods to:
    # - determine whether particular subsytems were init (e.g. `audio_init?`)
    # - initialize particular subsytems if uninitialized (e.g. `audio_init!`)
    ::Lummox::SDL::Initialization::SUBSYSTEMS.each do |subsystem|
      define_method(:"#{subsystem}_init?") { init?(subsystem) }
      define_method(:"#{subsystem}_init!") { init!(subsystem) }
    end

    def init_subsystems
      initialized_flags = was_init(0)
      SUBSYSTEM_FLAGS.filter { |_, flag| initialized_flags & flag == flag }.keys
    end

    def quit!
      quit
    end
  end
end

# frozen_string_literal: true

require_relative "sdl/zeitwerk"
require_relative "./sdl_error"

module Lummox::SDL
  # rubocop:disable Layout/HashAlignment
  SUBSYSTEM_FLAGS = {
    timer:          Initialization::SDL_INIT_TIMER,
    audio:          Initialization::SDL_INIT_AUDIO,
    video:          Initialization::SDL_INIT_VIDEO,
    joystick:       Initialization::SDL_INIT_JOYSTICK,
    haptic:         Initialization::SDL_INIT_HAPTIC,
    gamecontroller: Initialization::SDL_INIT_GAMECONTROLLER,
    events:         Initialization::SDL_INIT_EVENTS,
    sensor:         Initialization::SDL_INIT_SENSOR
  }.freeze
  # rubocop:enable Layout/HashAlignment
  SUBSYSTEMS = SUBSYSTEM_FLAGS.keys.freeze

  class << self
    def init!(*subsystems)
      subsystems = SUBSYSTEMS if subsystems.nil? || subsystems.empty?
      return if init?(*subsystems)

      flags = flags_from_subsystems(*subsystems)
      initialized_flags = Initialization.was_init(0)
      success_code = Initialization.init(flags ^ initialized_flags)
      ::Lummox::SDLError.raise_if { success_code.negative? }
    end

    def init?(*subsystems)
      flags = flags_from_subsystems(*subsystems)
      Initialization.was_init(flags) == flags
    end

    # TRICKY: Create helper methods to:
    # - determine whether particular subsytems were init (e.g. `audio_init?`)
    # - initialize particular subsytems if uninitialized (e.g. `audio_init!`)
    SUBSYSTEMS.each do |subsystem|
      define_method(:"#{subsystem}_init?") { init?(subsystem) }
      define_method(:"#{subsystem}_init!") { init!(subsystem) }
    end

    def init_subsystems
      initialized_flags = Initialization.was_init(0)
      SUBSYSTEM_FLAGS.filter { |_, flag| initialized_flags & flag == flag }.keys
    end

    def quit!
      Initialization.quit
    end

    def flags_from_subsystems(*subsystems)
      SUBSYSTEM_FLAGS.values_at(*subsystems).inject(:|)
    end
  end

  private_class_method :flags_from_subsystems
end

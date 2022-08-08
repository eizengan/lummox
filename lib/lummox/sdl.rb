# frozen_string_literal: true

module Lummox::SDL
  # rubocop:disable Layout/HashAlignment
  SUBSYSTEM_FLAGS = {
    timer:          Core::Initialization::SDL_INIT_TIMER,
    audio:          Core::Initialization::SDL_INIT_AUDIO,
    video:          Core::Initialization::SDL_INIT_VIDEO,
    joystick:       Core::Initialization::SDL_INIT_JOYSTICK,
    haptic:         Core::Initialization::SDL_INIT_HAPTIC,
    gamecontroller: Core::Initialization::SDL_INIT_GAMECONTROLLER,
    events:         Core::Initialization::SDL_INIT_EVENTS,
    sensor:         Core::Initialization::SDL_INIT_SENSOR
  }.freeze
  # rubocop:enable Layout/HashAlignment
  SUBSYSTEMS = SUBSYSTEM_FLAGS.keys.freeze

  class << self
    def init!(*subsystems)
      subsystems = SUBSYSTEMS if subsystems.nil? || subsystems.empty?
      return if init?(*subsystems)

      flags = flags_from_subsystems(*subsystems)
      initialized_flags = Core.was_init(0)
      success_code = Core.init(flags ^ initialized_flags)
      Error.raise_if { success_code.negative? }
    end

    def init?(*subsystems)
      flags = flags_from_subsystems(*subsystems)
      Core.was_init(flags) == flags
    end

    # TRICKY: Create helper methods to:
    # - determine whether particular subsytems were init (e.g. `audio_init?`)
    # - initialize particular subsytems if uninitialized (e.g. `audio_init!`)
    SUBSYSTEMS.each do |subsystem|
      define_method(:"#{subsystem}_init?") { init?(subsystem) }
      define_method(:"#{subsystem}_init!") { init!(subsystem) }
    end

    def init_subsystems
      initialized_flags = Core.was_init(0)
      SUBSYSTEM_FLAGS.filter { |_, flag| initialized_flags & flag == flag }.keys
    end

    def quit!
      Core.quit
    end

    def flags_from_subsystems(*subsystems)
      SUBSYSTEM_FLAGS.values_at(*subsystems).inject(:|)
    end
  end

  private_class_method :flags_from_subsystems
end

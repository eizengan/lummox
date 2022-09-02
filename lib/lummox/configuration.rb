# frozen_string_literal: true

require "singleton"
require "forwardable"

class Lummox::Configuration
  SDL_FLAGS_FOR_SUBSYSTEMS = {
    audio: Lummox::SDL::Core::INIT_AUDIO,
    controller: Lummox::SDL::Core::INIT_GAME_CONTROLLER,
    events: Lummox::SDL::Core::INIT_EVENTS,
    # haptic: Lummox::SDL::Core::INIT_HAPTIC,
    joystick: Lummox::SDL::Core::INIT_JOYSTICK,
    # sensor: Lummox::SDL::Core::INIT_SENSOR,
    timer: Lummox::SDL::Core::INIT_TIMER,
    video: Lummox::SDL::Core::INIT_VIDEO
  }.freeze
  SUBSYSTEMS = SDL_FLAGS_FOR_SUBSYSTEMS.keys.freeze

  include Singleton
  extend SingleForwardable

  def_delegators :instance, :init_subsystems, :init_subsystems=, :sdl_init_flags

  # configuration methods

  def init_subsystems
    @init_subsystems ||= SUBSYSTEMS
  end

  def init_subsystems=(*subsystems)
    @init_subsystems = subsystems
  end

  # initialization helpers

  def sdl_init_flags
    SDL_FLAGS_FOR_SUBSYSTEMS.values_at(*init_subsystems).inject(:|)
  end
end

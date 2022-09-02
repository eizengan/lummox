# frozen_string_literal: true

require "singleton"
require "forwardable"

class Lummox::Configuration
  SDL_FLAGS_FOR_SUBSYSTEMS = {
    audio: Lummox::SDL::INIT_AUDIO,
    controller: Lummox::SDL::INIT_GAME_CONTROLLER,
    events: Lummox::SDL::INIT_EVENTS,
    # haptic: Lummox::SDL::INIT_HAPTIC,
    joystick: Lummox::SDL::INIT_JOYSTICK,
    # sensor: Lummox::SDL::INIT_SENSOR,
    timer: Lummox::SDL::INIT_TIMER,
    video: Lummox::SDL::INIT_VIDEO
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

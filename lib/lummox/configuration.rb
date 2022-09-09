# frozen_string_literal: true

require "singleton"
require "forwardable"

class Lummox::Configuration
  InitFlags = Lummox::Helpers::FlagSet.for(Lummox::SDL::INIT_FLAGS, prefix: :INIT_) # rubocop:disable Style/MutableConstant

  include Singleton
  extend SingleForwardable

  def_delegators :instance, :init_subsystems, :init_subsystems=, :sdl_init_flags

  # configuration methods

  def init_subsystems
    @init_subsystems ||= InitFlags.flags
  end

  def init_subsystems=(*subsystems)
    @init_subsystems = subsystems
  end

  # initialization helpers

  def sdl_init_flags
    InitFlags.new(*init_subsystems).value
  end
end

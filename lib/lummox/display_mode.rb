# frozen_string_literal: true

require "forwardable"

class Lummox::DisplayMode
  extend Forwardable

  attr_reader :sdl_display_mode
  def_delegators :sdl_display_mode, :format, :format=,
                                    :refresh_rate, :refresh_rate=,
                                    :driver_data, :driver_data=
  def_delegator :sdl_display_mode, :w, :width
  def_delegator :sdl_display_mode, :w=, :width=
  def_delegator :sdl_display_mode, :h, :height
  def_delegator :sdl_display_mode, :h=, :height=

  def initialize(sdl_display_mode = nil)
    sdl_display_mode ||= Lummox::SDL::Core::DisplayMode.new
    @sdl_display_mode = sdl_display_mode
  end

  def inspect
    "#<Lummox::DisplayMode #{width}x#{height} @ #{refresh_rate}Hz>"
  end
end

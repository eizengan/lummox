# frozen_string_literal: true

# TODO:
# IGNORE:
# - get_num_video_drivers    - are these actually even helpful?
# - get_current_video_driver - are these actually even helpful?
# - get_video_driver         - are these actually even helpful?

class Lummox::Display
  attr_reader :display_index

  def self.all
    size = Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_num_video_displays }
    Array.new(size) { |display_index| new(display_index) }
  end

  def initialize(display_index)
    @display_index = display_index
  end

  def name
    Lummox::SDLError.raise_if(:nil?) { Lummox::SDL.get_display_name(display_index) }
  end

  def bounds
    bounds = Lummox::SDL::Rect.new
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_display_bounds(display_index, bounds) }
    Lummox::Rect.new(sdl_rect: bounds)
  end

  def usable_bounds
    usable_bounds = Lummox::SDL::Rect.new
    Lummox::SDLError.raise_if(:negative?) do
      Lummox::SDL.get_display_usable_bounds(display_index, usable_bounds)
    end
    Lummox::Rect.new(sdl_rect: usable_bounds)
  end

  def display_modes
    size = Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_num_display_modes(display_index) }
    Array.new(size) do |mode_index|
      display_mode = Lummox::DisplayMode.new
      Lummox::SDLError.raise_if(:negative?) do
        Lummox::SDL.get_display_mode(display_index, mode_index, display_mode.sdl_display_mode)
      end
      display_mode
    end
  end

  def current_display_mode
    display_mode = Lummox::DisplayMode.new
    Lummox::SDLError.raise_if(:negative?) do
      Lummox::SDL.get_current_display_mode(display_index, display_mode.sdl_display_mode)
    end
    display_mode
  end

  def desktop_display_mode
    display_mode = Lummox::DisplayMode.new
    Lummox::SDLError.raise_if(:negative?) do
      Lummox::SDL.get_desktop_display_mode(display_index, display_mode.sdl_display_mode)
    end
    display_mode
  end
end

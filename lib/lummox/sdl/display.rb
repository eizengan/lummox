# frozen_string_literal: true

# TODO:
# IGNORE:
# - get_num_video_drivers    - are these actually even helpful?
# - get_current_video_driver - are these actually even helpful?
# - get_video_driver         - are these actually even helpful?

class Lummox::SDL::Display
  attr_accessor :display_index

  def self.all
    size = Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.get_num_video_displays }
    Array.new(size) { |display_index| new(display_index) }
  end

  def initialize(display_index)
    @display_index = display_index
  end

  def name
    Lummox::SDL::Error.raise_if(:nil?) { Lummox::SDL::Core.get_display_name(@display_index) }
  end

  def bounds
    bounds = Lummox::SDL::Core::Rect.new
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.get_display_bounds(@display_index, bounds) }
    bounds
  end

  def usable_bounds
    usable_bounds = Lummox::SDL::Core::Rect.new
    Lummox::SDL::Error.raise_if(:negative?) do
      Lummox::SDL::Core.get_display_usable_bounds(@display_index, usable_bounds)
    end
    usable_bounds
  end

  def display_modes
    size = Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.get_num_display_modes(@display_index) }
    Array.new(size) do |mode_index|
      display_mode = Lummox::SDL::Core::DisplayMode.new
      Lummox::SDL::Error.raise_if(:negative?) do
        Lummox::SDL::Core.get_display_mode(@display_index, mode_index, display_mode)
      end
      display_mode
    end
  end

  def current_display_mode
    display_mode = Lummox::SDL::Core::DisplayMode.new
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.get_current_display_mode(@display_index, display_mode) }
    display_mode
  end

  def desktop_display_mode
    display_mode = Lummox::SDL::Core::DisplayMode.new
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.get_desktop_display_mode(@display_index, display_mode) }
    display_mode
  end
end

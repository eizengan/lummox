# frozen_string_literal: true

require "ffi"

class Lummox::Window::DisplaySettings
  attr_reader :window

  def initialize(window)
    @window = window
  end

  def display
    display_index = Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_window_display_index(window.pointer) }
    Lummox::Display.new(display_index)
  end

  def fullscreen=(option)
    if option
      enable_fullscreen(desktop: option == :desktop)
    else
      disable_fullscreen
    end
    fullscreen?
  end

  def fullscreen?
    window_flags_include?(:fullscreen)
  end

  def display_mode=(display_mode)
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.set_window_display_mode(window.pointer, display_mode) }
  end

  def display_mode
    sdl_display_mode = Lummox::SDL::DisplayMode.new
    Lummox::SDLError.raise_if(:negative?) do
      Lummox::SDL.get_window_display_mode(window.pointer, sdl_display_mode)
    end
    Lummox::Display::Mode.new(sdl_display_mode)
  end

  def borderless=(borderless)
    Lummox::SDL.set_window_bordered(window.pointer, :"#{!borderless}")
    borderless?
  end

  def borderless?
    window_flags_include?(:borderless)
  end

  def border_sizes
    size_pointers = {
      top: Lummox::SDL::IntPtr.new,
      left: Lummox::SDL::IntPtr.new,
      bottom: Lummox::SDL::IntPtr.new,
      right: Lummox::SDL::IntPtr.new
    }
    Lummox::SDLError.raise_if(:negative?) do
      Lummox::SDL.get_window_borders_size(pointer, *size_pointers.values)
    end
    size_pointers.transform_values!(&:value)
  end

  def resizable=(resizable)
    Lummox::SDL.set_window_resizable(window.pointer, :"#{resizable}")
    resizable?
  end

  def resizable?
    window_flags_include?(:resizable)
  end

  def size=(size)
    Lummox::SDL.set_window_size(window.pointer, *size)
  end

  def size
    size_pointers = Array.new(2) { Lummox::SDL::IntPtr.new }
    Lummox::SDL.get_window_size(window.pointer, *size_pointers)
    size_pointers.map(&:value)
  end

  def maximum_size=(size)
    Lummox::SDL.set_window_maximum_size(window.pointer, *size)
  end

  def maximum_size
    size_pointers = Array.new(2) { Lummox::SDL::IntPtr.new }
    Lummox::SDL.get_window_maximum_size(window.pointer, *size_pointers)
    size_pointers.map { |p| p.null? ? nil : p.value }
  end

  def minimum_size=(size)
    Lummox::SDL.set_window_minimum_size(window.pointer, *size)
  end

  def minimum_size
    size_pointers = Array.new(2) { Lummox::SDL::IntPtr.new }
    Lummox::SDL.get_window_maximum_size(window.pointer, *size_pointers)
    size_pointers.map { |p| p.null? ? nil : p.value }
  end

  private

  def window_flags_include?(flag)
    flags_value = Lummox::SDL.get_window_flags(window.pointer)
    Lummox::Window::WindowFlags.new(value: flags_value).include?(flag)
  end

  def enable_fullscreen(desktop:)
    flag_name = desktop ? :fullscreen_desktop : :fullscreen
    flag_value = WindowFlags.new(flag_name).value
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.set_window_fullscreen(window.pointer, flag_value) }
  end

  def disable_fullscreen
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.set_window_fullscreen(window.pointer, 0) }
  end
end

# frozen_string_literal: true

require "ffi"
require "forwardable"
require "singleton"

# TODO:
# - get_global_mouse_state, %i[int_pointer int_pointer], :uint32
# - get_mouse_state, %i[int_pointer int_pointer], :uint32
#
# - get_relative_mouse_mode, [], :bool
# - set_relative_mouse_mode, [:bool], :int # negative if error
# - get_relative_mouse_state, %i[int_pointer int_pointer], :uint32
# NEXT UP:
# - capture_mouse, [:bool], :int # negative if error
# IGNORE:
class Lummox::Mouse
  include Singleton
  extend SingleForwardable

  def_delegators :instance, :focused_window, :relative?, :enable_relative, :disable_relative, :warp_to, :position

  def initialize
    @x_pointer = Lummox::SDL::IntPtr.new
    @y_pointer = Lummox::SDL::IntPtr.new
  end

  def focused_window
    window_pointer = Lummox::SDL.get_mouse_focus
    Lummox::Window.find_instance(window_pointer.address)
  end

  def warp_to(x, y, in_window: nil)
    if in_window.nil?
      Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.warp_mouse_global(x, y) }
    elsif in_window == :current
      Lummox::SDL.warp_mouse_in_window(nil, x, y)
    else
      Lummox::SDL.warp_mouse_in_window(in_window.pointer, x, y)
    end
  end

  def position(global: false)
    if global
      Lummox::SDL.get_global_mouse_state(@x_pointer, @y_pointer)
    else
      Lummox::SDL.get_mouse_state(@x_pointer, @y_pointer)
    end

    [@x_pointer.value, @y_pointer.value]
  end
end

# frozen_string_literal: true

require "ffi"

# TODO:
# IGNORE:
# - set_window_modal_for - raises "That operation is not supported" MacOS; try Windows/Linux?

# rubocop:disable Metrics/ClassLength

class Lummox::Window
  WindowFlags = Lummox::Helpers::FlagSet.for(Lummox::SDL::WINDOW_FLAGS, prefix: :WINDOW_) # rubocop:disable Style/MutableConstant

  include Lummox::Helpers::InstanceRegistry

  attr_reader :pointer, :title

  def initialize(title, size:, position: nil, flags: [:opengl])
    position = translate_position(position)

    @title = title
    @pointer = create_managed_pointer(title, position, size, WindowFlags.new(*flags).value)
    self.class.register_instance(pointer.address, self)
  end

  def self.from_id(id)
    pointer = Lummox::SDLError.raise_if(:null?) { Lummox::SDL.get_window_from_id(id) }
    find_instance(pointer.address)
  end

  def close!
    self.class.deregister_instance(pointer.address)
    Lummox::SDL.destroy_window(pointer)
    @pointer = FFI::Pointer::NULL
  end

  def closed?
    pointer.null?
  end

  def id
    Lummox::SDLError.raise_if(:zero?) { Lummox::SDL.get_window_id(pointer) }
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

  def display_mode
    display_mode = Lummox::DisplayMode.new
    Lummox::SDLError.raise_if(:negative?) do
      Lummox::SDL.get_window_display_mode(pointer, display_mode.sdl_display_mode)
    end
    display_mode
  end

  def display_mode=(display_mode)
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.set_window_display_mode(pointer, display_mode) }
  end

  def borderless=(borderless)
    Lummox::SDL.set_window_bordered(pointer, :"#{!borderless}")
    borderless?
  end

  def borderless?
    window_flags_include?(:borderless)
  end

  def resizable=(resizable)
    Lummox::SDL.set_window_resizable(pointer, :"#{resizable}")
    resizable?
  end

  def resizable?
    window_flags_include?(:resizable)
  end

  def title=(new_title)
    Lummox::SDL.set_window_title(pointer, new_title)
    @title = new_title
  end

  def display
    display_index = Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_window_display_index(pointer) }
    Lummox::Display.new(display_index)
  end

  def position
    position_pointers = Array.new(2) { Lummox::SDL::IntPtr.new }
    Lummox::SDL.get_window_position(pointer, *position_pointers)
    position_pointers.map(&:value)
  end

  def position=(position)
    Lummox::SDL.set_window_position(pointer, *position)
  end

  def size
    size_pointers = Array.new(2) { Lummox::SDL::IntPtr.new }
    Lummox::SDL.get_window_size(pointer, *size_pointers)
    size_pointers.map(&:value)
  end

  def size=(size)
    Lummox::SDL.set_window_size(pointer, *size)
  end

  def maximum_size
    size_pointers = Array.new(2) { Lummox::SDL::IntPtr.new }
    Lummox::SDL.get_window_maximum_size(pointer, *size_pointers)
    size_pointers.map { |p| p.null? ? nil : p.value }
  end

  def maximum_size=(size)
    Lummox::SDL.set_window_maximum_size(pointer, *size)
  end

  def minimum_size
    size_pointers = Array.new(2) { Lummox::SDL::IntPtr.new }
    Lummox::SDL.get_window_maximum_size(pointer, *size_pointers)
    size_pointers.map { |p| p.null? ? nil : p.value }
  end

  def minimum_size=(size)
    Lummox::SDL.set_window_minimum_size(pointer, *size)
  end

  def opacity
    opacity_pointer = Lummox::SDL::FloatPtr.new
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_window_opacity(pointer, opacity_pointer) }
    opacity_pointer.value
  end

  def opacity=(opacity)
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.set_window_opacity(pointer, opacity) }
  end

  def minimize
    Lummox::SDL.minimize_window(pointer)
  end

  def maximize
    Lummox::SDL.maximize_window(pointer)
  end

  def restore
    Lummox::SDL.restore_window(pointer)
  end

  def hide
    Lummox::SDL.hide_window(pointer)
  end

  def show
    Lummox::SDL.show_window(pointer)
  end

  def raise
    Lummox::SDL.raise_window(pointer)
  end

  def flash(until_focused: false)
    operation = until_focused ? :flash_until_focused : :flash_briefly
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.flash_window(pointer, operation) }
  end

  def cancel_flash
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.flash_window(pointer, :flash_cancel) }
  end

  def grab_input
    Lummox::SDL.set_window_grab(pointer, :true)
  end

  def release_input
    Lummox::SDL.set_window_grab(pointer, :false)
  end

  def input_grabbed?
    Lummox::SDL.get_window_grab(pointer) == :true
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

  private

  def window_flags_include?(flag)
    flags_value = Lummox::SDL.get_window_flags(pointer)
    WindowFlags.new(value: flags_value).include?(flag)
  end

  def enable_fullscreen(desktop:)
    flag_name = desktop ? :fullscreen_desktop : :fullscreen
    flag_value = WindowFlags.new(flag_name).value
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.set_window_fullscreen(pointer, flag_value) }
  end

  def disable_fullscreen
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.set_window_fullscreen(pointer, 0) }
  end

  def create_managed_pointer(title, position, size, flags)
    pointer = Lummox::SDLError.raise_if(:null?) { Lummox::SDL.create_window(title, *position, *size, flags) }
    FFI::AutoPointer.new(pointer, method(:close!))
  end

  def translate_position(position_arg)
    if position_arg.nil?
      [Lummox::SDL::WINDOW_POS_UNDEFINED, Lummox::SDL::WINDOW_POS_UNDEFINED]
    elsif position == :centered
      [Lummox::SDL::WINDOW_POS_CENTERED, Lummox::SDL::WINDOW_POS_CENTERED]
    else
      position_arg
    end
  end
end

# rubocop:enable Metrics/ClassLength

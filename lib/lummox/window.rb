# frozen_string_literal: true

require "ffi"

# TODO:
# IGNORE:
# - set_window_modal_for - raises "That operation is not supported" MacOS; try Windows/Linux?

class Lummox::Window
  WindowFlags = Lummox::Helpers::FlagSet.for(Lummox::SDL::WINDOW_FLAGS, prefix: :WINDOW_) # rubocop:disable Style/MutableConstant

  include Lummox::Helpers::InstanceRegistry

  attr_reader :pointer, :title, :display_settings

  def initialize(title, size:, position: nil, flags: [:opengl])
    position = translate_position(position)

    @title = title
    @pointer = create_managed_pointer(title, position, size, WindowFlags.new(*flags).value)
    @display_settings = DisplaySettings.new(self)
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

  def title=(new_title)
    Lummox::SDL.set_window_title(pointer, new_title)
    @title = new_title
  end

  def position
    position_pointers = Array.new(2) { Lummox::SDL::IntPtr.new }
    Lummox::SDL.get_window_position(pointer, *position_pointers)
    position_pointers.map(&:value)
  end

  def position=(position)
    Lummox::SDL.set_window_position(pointer, *position)
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

  def opacity=(opacity)
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.set_window_opacity(pointer, opacity) }
  end

  def opacity
    opacity_pointer = Lummox::SDL::FloatPtr.new
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_window_opacity(pointer, opacity_pointer) }
    opacity_pointer.value
  end

  private

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

# frozen_string_literal: true

require "ffi"

# TODO:
# IGNORE:
# - set_window_modal_for - raises "That operation is not supported" MacOS; try Windows/Linux?

# rubocop:disable Metrics/ClassLength

class Lummox::SDL::Window
  include Lummox::SDL::InstanceRegistry

  attr_reader :pointer, :title

  # TODO: opts to set up flags, ability to ingest raw flags
  def initialize(title, size:, position: nil)
    position = translate_position(position)

    @title = title
    @fullscreen = false
    @bordered = true
    @resizable = false
    flags = Lummox::SDL::Core::WINDOW_OPENGL
    @pointer = create_managed_pointer(title, position, size, flags)
    self.class.register_instance(@pointer.address, self)
  end

  def self.from_id(id)
    pointer = Lummox::SDL::Error.raise_if(:nil?) { Lummox::SDL::Core.get_window_from_id(id) }
    self.class.find_instance(pointer.address)
  end

  def self.all
    @windows.values
  end

  def close!
    self.class.deregister_instance(@pointer.address)
    Lummox::SDL::Core.destroy_window(@pointer)
    @pointer = FFI::Pointer::NULL
  end

  def closed?
    @pointer.null?
  end

  def id
    Lummox::SDL::Error.raise_if(:zero?) { Lummox::SDL::Core.get_window_id(@pointer) }
  end

  def enable_fullscreen(desktop: true)
    flags = desktop ? Lummox::SDL::Core::WINDOW_FULLSCREEN_DESKTOP : Lummox::SDL::Core::WINDOW_FULLSCREEN
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.set_window_fullscreen(@pointer, flags) }
    @fullscreen = true
  end

  def disable_fullscreen
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.set_window_fullscreen(@pointer, 0) }
    @fullscreen = false
  end

  def fullscreen?
    @fullscreen
  end

  def display_mode
    display_mode = Lummox::SDL::Core::DisplayMode.new
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.get_window_display_mode(@pointer, display_mode) }
    display_mode
  end

  def display_mode=(display_mode)
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.set_window_display_mode(@pointer, display_mode) }
  end

  def bordered=(bordered)
    raise Lummox::SDL::Error, "Fullscreen windows cannot change bordered state" if fullscreen?

    Lummox::SDL::Core.set_window_bordered(@pointer, bordered.to_s.to_sym)
    @bordered = bordered
  end

  def bordered?
    @bordered
  end

  def resizable=(resizable)
    raise Lummox::SDL::Error, "Fullscreen windows cannot change resizability state" if fullscreen?

    Lummox::SDL::Core.set_window_resizable(@pointer, resizable.to_s.to_sym)
    @resizable = resizable
  end

  def resizable?
    @resizable
  end

  def title=(new_title)
    Lummox::SDL::Core.set_window_title(@pointer, new_title)
    @title = new_title
  end

  def display
    display_index = Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.get_window_display_index(@pointer) }
    Lummox::SDL::Display.new(display_index)
  end

  def position
    position_pointers = Array.new(2) { Lummox::SDL::Core::IntPtr.new }
    Lummox::SDL::Core.get_window_position(@pointer, *position_pointers)
    position_pointers.map(&:value)
  end

  def position=(position)
    Lummox::SDL::Core.set_window_position(@pointer, *position)
  end

  def size
    size_pointers = Array.new(2) { Lummox::SDL::Core::IntPtr.new }
    Lummox::SDL::Core.get_window_size(@pointer, *size_pointers)
    size_pointers.map(&:value)
  end

  def size=(size)
    Lummox::SDL::Core.set_window_size(@pointer, *size)
  end

  def maximum_size
    size_pointers = Array.new(2) { Lummox::SDL::Core::IntPtr.new }
    Lummox::SDL::Core.get_window_maximum_size(@pointer, *size_pointers)
    size_pointers.map { |p| p.null? ? nil : p.value }
  end

  def maximum_size=(size)
    Lummox::SDL::Core.set_window_maximum_size(@pointer, *size)
  end

  def minimum_size
    size_pointers = Array.new(2) { Lummox::SDL::Core::IntPtr.new }
    Lummox::SDL::Core.get_window_maximum_size(@pointer, *size_pointers)
    size_pointers.map { |p| p.null? ? nil : p.value }
  end

  def minimum_size=(size)
    Lummox::SDL::Core.set_window_minimum_size(@pointer, *size)
  end

  def opacity
    opacity_pointer = Lummox::SDL::Core::FloatPtr.new
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.get_window_opacity(@pointer, opacity_pointer) }
    opacity_pointer.value
  end

  def opacity=(opacity)
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.set_window_opacity(@pointer, opacity) }
  end

  def minimize
    Lummox::SDL::Core.minimize_window(@pointer)
  end

  def maximize
    Lummox::SDL::Core.maximize_window(@pointer)
  end

  def restore
    Lummox::SDL::Core.restore_window(@pointer)
  end

  def hide
    Lummox::SDL::Core.hide_window(@pointer)
  end

  def show
    Lummox::SDL::Core.show_window(@pointer)
  end

  def raise
    Lummox::SDL::Core.raise_window(@pointer)
  end

  def flash(until_focused: false)
    operation = until_focused ? :flash_until_focused : :flash_briefly
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.flash_window(@pointer, operation) }
  end

  def cancel_flash
    Lummox::SDL::Error.raise_if(:negative?) { Lummox::SDL::Core.flash_window(@pointer, :flash_cancel) }
  end

  def grab_input
    Lummox::SDL::Core.set_window_grab(@pointer, :true)
  end

  def release_input
    Lummox::SDL::Core.set_window_grab(@pointer, :false)
  end

  def input_grabbed?
    Lummox::SDL::Core.get_window_grab(@pointer) == :true
  end

  def border_sizes
    size_pointers = {
      top: Lummox::SDL::Core::IntPtr.new,
      left: Lummox::SDL::Core::IntPtr.new,
      bottom: Lummox::SDL::Core::IntPtr.new,
      right: Lummox::SDL::Core::IntPtr.new
    }
    Lummox::SDL::Error.raise_if(:negative?) do
      Lummox::SDL::Core.get_window_borders_size(@pointer, *size_pointers.values)
    end
    size_pointers.transform_values!(&:value)
  end

  private

  def create_managed_pointer(title, position, size, flags)
    pointer = Lummox::SDL::Error.raise_if(:nil?) { Lummox::SDL::Core.create_window(title, *position, *size, flags) }
    FFI::AutoPointer.new(pointer, method(:close!))
  end

  def translate_position(position_arg)
    if position_arg.nil?
      [Lummox::SDL::Core::WINDOW_POS_UNDEFINED, Lummox::SDL::Core::WINDOW_POS_UNDEFINED]
    elsif position == :centered
      [Lummox::SDL::Core::WINDOW_POS_CENTERED, Lummox::SDL::Core::WINDOW_POS_CENTERED]
    else
      position_arg
    end
  end
end

# rubocop:enable Metrics/ClassLength

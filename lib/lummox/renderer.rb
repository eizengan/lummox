# frozen_string_literal: true

# - render_copy
# - render_copy_f
# - render_copy_ex
# - render_copy_ex_f
class Lummox::Renderer
  RendererFlags = Lummox::Helpers::FlagSet.for(Lummox::SDL::RENDERER_FLAGS, prefix: :RENDERER_) # rubocop:disable Style/MutableConstant

  extend Lummox::Helpers::InstanceRegistry

  attr_reader :window, :pointer

  def initialize(window)
    @window = window
    @pointer = create_managed_pointer(window)
    self.class.register_instance(pointer.address, self)
  end

  def close!
    self.class.deregister_instance(pointer.address)
    Lummox::SDL.destroy_renderer(pointer)
    @window.instance_variable_set(:@renderer, nil)
    @window = nil
    @pointer = FFI::Pointer::NULL
  end

  def driver
    info = Lummox::SDL::RendererInfo.new
    Lummox::SDL.get_renderer_info(pointer, info)
    Driver.new(info)
  end

  def output_size
    size_pointers = Array.new(2) { Lummox::SDL::IntPtr.new }
    Lummox::SDL.get_renderer_output_size(pointer, *size_pointers)
    size_pointers.map(&:value)
  end

  def color=(color)
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.set_render_draw_color(pointer, *color) }
  end

  def color
    Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_render_draw_color(pointer, *color_pointers) }
    color_pointers.map(&:value)
  end

  def with_color(temporary_color, &action)
    color_to_restore = color
    self.color = temporary_color
    action.call
    self.color = color_to_restore
  end

  private

  def color_pointers
    @color_pointers ||= Array.new(4) { Lummox::SDL::Uint8Ptr.new }
  end

  def create_managed_pointer(window)
    flags = RendererFlags.new(:accelerated, :present_vsync, :target_texture)
    pointer = Lummox::SDLError.raise_if(:null?) { Lummox::SDL.create_renderer(window.pointer, -1, flags.value) }
    FFI::AutoPointer.new(pointer, method(:close!))
  end
end

# frozen_string_literal: true

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

  private

  def create_managed_pointer(window)
    flags = RendererFlags.new(:accelerated, :present_vsync, :target_texture)
    pointer = Lummox::SDLError.raise_if(:null?) { Lummox::SDL.create_renderer(window.pointer, -1, flags.value) }
    FFI::AutoPointer.new(pointer, method(:close!))
  end
end

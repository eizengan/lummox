# frozen_string_literal: true

require "forwardable"

class Lummox::Renderer::Driver
  extend Forwardable

  def self.all_instances
    num_drivers = Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_num_render_drivers }
    sdl_render_infos = Array.new(num_drivers) { Lummox::SDL::RendererInfo.new }
    sdl_render_infos.each_with_index do |info, i|
      Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.get_render_driver_info(i, info) }
    end
    sdl_render_infos.map { |i| new(i) }
  end

  attr_reader :sdl_renderer_info

  def_delegators :sdl_renderer_info, :name, :max_texture_width, :max_texture_height

  def initialize(sdl_renderer_info)
    @sdl_renderer_info = sdl_renderer_info
  end

  def flags
    @flags ||= Lummox::Renderer::RendererFlags.new(value: sdl_renderer_info.flags)
  end

  def accelerated?
    flags.include?(:accelerated)
  end

  def software?
    flags.include?(:software)
  end

  def vsync?
    flags.include?(:present_vsync)
  end

  def render_to_texture?
    flags.include?(:target_texture)
  end

  def type
    if accelerated?
      :accelerated
    elsif software?
      :software
    else
      :unknown
    end
  end

  def texture_formats
    size = sdl_renderer_info.num_texture_formats
    @texture_formats ||= Array.new(size) { |i| Lummox::TextureFormat.new(sdl_renderer_info.texture_formats[i]) }
  end

  def inspect
    "#<#{self.class} name=#{name} type=#{type} texture_formats=#{sdl_renderer_info.num_texture_formats}>"
  end
end

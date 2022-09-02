# frozen_string_literal: true

class Lummox::Rect
  attr_accessor :x, :y, :width, :height

  # rubocop:disable Metrics/MethodLength, Metrics/ParameterLists, Naming/MethodParameterName

  def initialize(x = 0, y = 0, width = 0, height = 0, sdl_rect: nil)
    if sdl_rect.nil?
      @x = x
      @y = y
      @width = width
      @height = height
    else
      @x = sdl_rect.x
      @y = sdl_rect.y
      @width = sdl_rect.w
      @height = sdl_rect.h
    end
  end

  # rubocop:enable all

  def sdl_rect
    Lummox::SDL::Core::Rect.new(x: x, y: y, w: width, h: height)
  end

  def sdl_frect
    Lummox::SDL::Core::FRect.new(x: x, y: y, w: width, h: height)
  end

  def inspect
    "#<Lummox::Rect x=#{x} y=#{y} width=#{width} height=#{height}>"
  end
end

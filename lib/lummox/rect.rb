# frozen_string_literal: true

class Lummox::Rect
  attr_accessor :x, :y, :width, :height

  # rubocop:disable Metrics/MethodLength, Metrics/ParameterLists

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

  def position
    [x, y]
  end

  def size
    [width, height]
  end

  def sdl_rect(pointer = nil)
    Lummox::SDL::Rect.new(pointer, x: x, y: y, w: width, h: height)
  end

  def sdl_frect(pointer = nil)
    Lummox::SDL::FRect.new(pointer, x: x, y: y, w: width, h: height)
  end

  def inspect
    "#<Lummox::Rect x=#{x} y=#{y} width=#{width} height=#{height}>"
  end
end

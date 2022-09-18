# frozen_string_literal: true

class Lummox::Point
  extend Lummox::Helpers::Drawable
  self.default_drawing_type = :point
  register_drawing_method(:point, :render_draw_point) { |p| p.position.map(&:to_i) }
  register_drawing_method :point_float, :render_draw_point_f, &:position

  attr_accessor :x, :y

  def initialize(x = 0, y = 0, sdl_point: nil)
    if sdl_point.nil?
      @x = x
      @y = y
    else
      @x = sdl_point.x
      @y = sdl_point.y
    end
  end

  def position
    [x, y]
  end

  def sdl_point(pointer = nil)
    Lummox::SDL::Point.new(pointer, x: x, y: y)
  end

  def sdl_fpoint(pointer = nil)
    Lummox::SDL::FPoint.new(pointer, x: x, y: y)
  end

  def inspect
    "#<#{self.class} x=#{x} y=#{y}>"
  end
end

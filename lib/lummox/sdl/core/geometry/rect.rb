# frozen_string_literal: true

class Lummox::SDL::Core::Geometry::Rect < Lummox::SDL::Core::Struct
  layout :x, :int,
         :y, :int,
         :w, :int,
         :h, :int

  alias_method :width, :w
  alias_method :height, :h

  def inspect
    "#<Lummox::SDL::Rect x=#{x} y=#{y} width=#{width} height=#{height}>"
  end
end

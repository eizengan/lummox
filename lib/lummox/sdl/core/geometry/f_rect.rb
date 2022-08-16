# frozen_string_literal: true

class Lummox::SDL::Core::Geometry::FRect < Lummox::SDL::Core::Struct
  layout :x, :float,
         :y, :float,
         :w, :float,
         :h, :float

  alias_method :width, :w
  alias_method :height, :h

  def inspect
    "#<Lummox::SDL::Rect x=#{x} y=#{y} width=#{width} height=#{height}>"
  end
end

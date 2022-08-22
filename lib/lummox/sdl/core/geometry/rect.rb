# frozen_string_literal: true

class Lummox::SDL::Core::Geometry::Rect < Lummox::SDL::Core::Struct
  layout :x, :int,
         :y, :int,
         :w, :int,
         :h, :int

  alias width w
  alias height h

  def inspect
    "#<Lummox::SDL::Rect x=#{x} y=#{y} width=#{width} height=#{height}>"
  end
end

# frozen_string_literal: true

class Lummox::SDL::Geometry::Rect < Lummox::SDL::Struct
  layout :x, :int,
         :y, :int,
         :w, :int,
         :h, :int
end

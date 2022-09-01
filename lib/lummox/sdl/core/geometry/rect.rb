# frozen_string_literal: true

class Lummox::SDL::Core::Geometry::Rect < Lummox::SDL::Core::Struct
  layout :x, :int,
         :y, :int,
         :w, :int,
         :h, :int
end

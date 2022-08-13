# frozen_string_literal: true

class Lummox::SDL::Core::Geometry::Rect < FFI::Struct
  layout :x, :int,
         :y, :int,
         :w, :int,
         :h, :int
end

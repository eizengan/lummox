# frozen_string_literal: true

class Lummox::SDL::Core::Geometry::Point < FFI::Struct
  layout :x, :int,
         :y, :int
end

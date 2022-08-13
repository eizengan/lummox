# frozen_string_literal: true

class Lummox::SDL::Core::Geometry::FPoint < FFI::Struct
  layout :x, :float,
         :y, :float
end

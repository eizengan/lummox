# frozen_string_literal: true

class Lummox::SDL::Core::Rect::Point < FFI::Struct
  layout :x, :int,
         :y, :int
end

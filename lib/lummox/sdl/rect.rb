# frozen_string_literal: true

class Lummox::SDL::Rect < FFI::Struct
  layout *%i[
    x      int
    y      int
    width  int
    height int
  ]
end

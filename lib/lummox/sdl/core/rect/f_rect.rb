# frozen_string_literal: true

class Lummox::SDL::Core::Rect::FRect < FFI::Struct
  layout :x, :float,
         :y, :float,
         :w, :float,
         :h, :float
end

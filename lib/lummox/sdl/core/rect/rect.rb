# frozen_string_literal: true

class Lummox::SDL::Core::Rect::Rect < FFI::Struct
  layout :x,      :int,
         :y,      :int,
         :width,  :int,
         :height, :int
end

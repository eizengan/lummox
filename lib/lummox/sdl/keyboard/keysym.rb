# frozen_string_literal: true

class Lummox::SDL::Keyboard::Keysym < Lummox::SDL::Struct
  layout :scancode, Lummox::SDL::Keyboard::Scancode,
         :sym,      Lummox::SDL::Keyboard::Keycode,
         :mod,      :uint16,
         :unused,   :uint32
end

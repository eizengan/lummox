# frozen_string_literal: true

class Lummox::SDL::Core::Keyboard::Keysym < Lummox::SDL::Core::Struct
  layout :scancode, Lummox::SDL::Core::Keyboard::Scancode,
         :sym,      Lummox::SDL::Core::Keyboard::Keycode,
         :mod,      :uint16,
         :unused,   :uint32
end

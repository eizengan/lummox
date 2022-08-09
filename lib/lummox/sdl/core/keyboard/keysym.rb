# frozen_string_literal: true

class Lummox::SDL::Core::Keyboard::Keysym < FFI::Struct
  layout :scancode, Lummox::SDL::Core::Keyboard::Scancode,
         :keycode,  Lummox::SDL::Core::Keyboard::Keycode,
         :mod,      :uint16,
         :unused,   :uint32
end

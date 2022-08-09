# frozen_string_literal: true

class Lummox::SDL::Core::Events::Keysym < FFI::Struct
  layout :scancode, Lummox::SDL::Core::Events::Scancode,
         :keycode,  Lummox::SDL::Core::Events::Keycode,
         :mod, :uint16,
         :unused, :uint32
end

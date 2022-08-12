# frozen_string_literal: true

class Lummox::SDL::Core::Events::KeyboardEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :window_id,
         :state,     Lummox::SDL::Core::Events::ButtonState,
         :repeat,    :uint32,
         :keysym,    Lummox::SDL::Core::Keyboard::Keysym
end

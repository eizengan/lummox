# frozen_string_literal: true

class Lummox::SDL::Core::Events::KeyboardEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :state,     Lummox::SDL::Core::ButtonState,
         :repeat,    :uint8,
         :padding_2, :uint8,
         :padding_3, :uint8,
         :keysym,    Lummox::SDL::Core::Keyboard::Keysym
end

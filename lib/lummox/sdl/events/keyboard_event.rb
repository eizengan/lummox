# frozen_string_literal: true

class Lummox::SDL::Events::KeyboardEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :state,     Lummox::SDL::ButtonState,
         :repeat,    :uint8,
         :padding_2, :uint8,
         :padding_3, :uint8,
         :keysym,    Lummox::SDL::Keyboard::Keysym
end

# frozen_string_literal: true

class Lummox::SDL::Events::MouseButtonEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :which,     :uint32,
         :button,    Lummox::SDL::Mouse::MouseButton,
         :state,     Lummox::SDL::ButtonState,
         :clicks,    :uint8,
         :padding_1, :uint8,
         :x,         :int32,
         :y,         :int32
end

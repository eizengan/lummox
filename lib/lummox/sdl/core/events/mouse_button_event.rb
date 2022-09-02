# frozen_string_literal: true

class Lummox::SDL::Core::Events::MouseButtonEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :which,     :uint32,
         :button,    Lummox::SDL::Core::Mouse::MouseButton,
         :state,     Lummox::SDL::Core::ButtonState,
         :clicks,    :uint8,
         :padding_1, :uint8,
         :x,         :int32,
         :y,         :int32
end

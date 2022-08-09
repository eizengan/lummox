# frozen_string_literal: true

class Lummox::SDL::Core::Events::MouseButtonEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :which,     :uint32,
         :button,    Lummox::SDL::Core::Events::MouseButton,
         :state,     Lummox::SDL::Core::Events::ButtonState,
         :clicks,    :uint8,
         :x,         :int32,
         :y,         :int32
end
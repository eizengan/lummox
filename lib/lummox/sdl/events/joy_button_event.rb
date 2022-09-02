# frozen_string_literal: true

class Lummox::SDL::Events::JoyButtonEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :button,    :uint8,
         :state,     Lummox::SDL::ButtonState
end

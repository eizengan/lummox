# frozen_string_literal: true

class Lummox::SDL::Core::Events::JoyButtonEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :joystick_id,
         :button,    :uint8,
         :state,     Lummox::SDL::Core::Events::ButtonState
end

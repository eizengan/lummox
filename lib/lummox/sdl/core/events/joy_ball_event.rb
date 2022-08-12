# frozen_string_literal: true

class Lummox::SDL::Core::Events::JoyBallEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :joystick_id,
         :ball,      :uint8,
         :x_rel,     :int16
         :y_rel,     :int16
end

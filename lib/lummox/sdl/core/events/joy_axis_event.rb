# frozen_string_literal: true

class Lummox::SDL::Core::Events::JoyAxisEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :joystick_id,
         :axis,      :uint8,
         :value,     :int16
end

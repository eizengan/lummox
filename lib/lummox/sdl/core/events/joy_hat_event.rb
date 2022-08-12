# frozen_string_literal: true

class Lummox::SDL::Core::Events::JoyHatEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :joystick_id,
         :hat,       :uint8,
         :value,     :int16
end

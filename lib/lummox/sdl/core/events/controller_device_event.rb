# frozen_string_literal: true

class Lummox::SDL::Core::Events::ControllerDeviceEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :joystick_id
end

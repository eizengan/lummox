# frozen_string_literal: true

class Lummox::SDL::Core::Events::ControllerDeviceEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32
end

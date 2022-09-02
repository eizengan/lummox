# frozen_string_literal: true

class Lummox::SDL::Events::ControllerDeviceEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32
end

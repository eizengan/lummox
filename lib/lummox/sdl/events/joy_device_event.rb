# frozen_string_literal: true

class Lummox::SDL::Events::JoyDeviceEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32
end

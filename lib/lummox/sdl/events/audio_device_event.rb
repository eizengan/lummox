# frozen_string_literal: true

class Lummox::SDL::Events::AudioDeviceEvent < Lummox::SDL::Struct
  layout :type,       Lummox::SDL::Events::EventType,
         :timestamp,  :uint32,
         :which,      :uint32,
         :is_capture, :uint8
end

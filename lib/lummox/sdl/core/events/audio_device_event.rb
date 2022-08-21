# frozen_string_literal: true

class Lummox::SDL::Core::Events::AudioDeviceEvent < Lummox::SDL::Core::Struct
  layout :type,       Lummox::SDL::Core::Events::EventType,
         :timestamp,  :uint32,
         :which,      :uint32,
         :is_capture, :uint8
end

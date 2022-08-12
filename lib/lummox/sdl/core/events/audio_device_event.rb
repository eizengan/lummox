# frozen_string_literal: true

class Lummox::SDL::Core::Events::AudioDeviceEvent < FFI::Struct
  layout :type,       Lummox::SDL::Core::Events::EventType,
         :timestamp,  :uint32,
         :which,      :audio_device_id,
         :is_capture, :bool
end

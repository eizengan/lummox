# frozen_string_literal: true

class Lummox::SDL::Core::Events::JoyHatEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :hat,       :uint8,
         :value,     :int16
end

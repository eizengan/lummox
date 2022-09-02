# frozen_string_literal: true

class Lummox::SDL::Events::JoyHatEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :hat,       :uint8,
         :value,     :int16
end

# frozen_string_literal: true

class Lummox::SDL::Events::JoyAxisEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :axis,      :uint8,
         :value,     :int16
end

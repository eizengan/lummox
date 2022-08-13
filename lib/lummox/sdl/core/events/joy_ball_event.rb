# frozen_string_literal: true

class Lummox::SDL::Core::Events::JoyBallEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :ball,      :uint8,
         :x_rel,     :int16,
         :y_rel,     :int16
end

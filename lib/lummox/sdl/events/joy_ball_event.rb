# frozen_string_literal: true

class Lummox::SDL::Events::JoyBallEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :ball,      :uint8,
         :x_rel,     :int16,
         :y_rel,     :int16
end

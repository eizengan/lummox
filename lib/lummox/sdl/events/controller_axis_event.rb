# frozen_string_literal: true

class Lummox::SDL::Events::ControllerAxisEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :axis,      Lummox::SDL::GameController::GameControllerAxis,
         :padding_1, :uint8,
         :padding_2, :uint8,
         :padding_3, :uint8,
         :value,     :int16
end

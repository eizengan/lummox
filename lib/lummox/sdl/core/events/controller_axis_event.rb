# frozen_string_literal: true

class Lummox::SDL::Core::Events::ControllerAxisEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :axis,      Lummox::SDL::Core::GameController::GameControllerAxis,
         :padding_1, :uint8,
         :padding_2, :uint8,
         :padding_3, :uint8,
         :value,     :int16
end

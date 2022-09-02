# frozen_string_literal: true

class Lummox::SDL::Events::ControllerButtonEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :button,    Lummox::SDL::GameController::GameControllerButton,
         :state,     Lummox::SDL::ButtonState,
         :padding_1, :uint8,
         :padding_2, :uint8
end

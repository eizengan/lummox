# frozen_string_literal: true

class Lummox::SDL::Core::Events::ControllerButtonEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :button,    Lummox::SDL::Core::GameController::GameControllerButton,
         :state,     Lummox::SDL::Core::Events::ButtonState
end

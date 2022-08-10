# frozen_string_literal: true

class Lummox::SDL::Core::Events::ControllerAxisEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :which,     :int32,
         :axis,      Lummox::SDL::Core::GameController::GameControllerAxis,
         :value,     :int16
end

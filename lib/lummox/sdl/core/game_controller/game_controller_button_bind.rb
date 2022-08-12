# frozen_string_literal: true

class Lummox::SDL::Core::GameController::GameControllerButtonBind < FFI::Struct
  layout :bind_type, Lummox::SDL::Core::GameController::GameControllerBindType,
         :value,     Lummox::SDL::Core::GameController::GameControllerBindValue
end

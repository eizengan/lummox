# frozen_string_literal: true

class Lummox::SDL::Core::GameController::GameControllerButtonBind < Lummox::SDL::Core::Struct
  layout :bind_type, Lummox::SDL::Core::GameController::GameControllerBindType,
         :value,     Lummox::SDL::Core::GameController::GameControllerBindValue
end

# frozen_string_literal: true

class Lummox::SDL::GameController::GameControllerButtonBind < Lummox::SDL::Struct
  layout :bind_type, Lummox::SDL::GameController::GameControllerBindType,
         :value,     Lummox::SDL::GameController::GameControllerBindValue
end

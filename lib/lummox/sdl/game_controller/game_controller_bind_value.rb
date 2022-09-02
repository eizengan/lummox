# frozen_string_literal: true

class Lummox::SDL::GameController::GameControllerBindValue < FFI::Union
  class HatData < Lummox::SDL::Struct
    layout :hat,      :int,
           :hat_mask, :int
  end

  layout :button, :int,
         :axis,   :int,
         :hat,    HatData
end

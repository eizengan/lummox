# frozen_string_literal: true

class Lummox::SDL::Core::GameController::BindValue < FFI::Union
  class HatData < FFI::Struct
    layout :hat,      :int,
           :hat_mask, :int
  end

  layout :button, :int,
         :axis,   :int,
         :hat,    HatData
end

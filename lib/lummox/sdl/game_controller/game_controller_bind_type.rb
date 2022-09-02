# frozen_string_literal: true

require "ffi"

module Lummox::SDL::GameController
  GameControllerBindType = Lummox::SDL.enum(
    FFI::Type::INT,
    :controller_bind_type_none, 0,
    :controller_bind_type_button,
    :controller_bind_type_axis,
    :controller_bind_type_hat
  ).freeze
end

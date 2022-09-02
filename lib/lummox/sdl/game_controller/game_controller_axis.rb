# frozen_string_literal: true

require "ffi"

module Lummox::SDL::GameController
  GameControllerAxis = Lummox::SDL.enum(
    # TODO: This type is used by a struct, but the declaration is quite apparently int; does this work in all cases?
    FFI::Type::UINT8,
    :controller_axis_invalid, -1,
    :controller_axis_left_x,
    :controller_axis_left_y,
    :controller_axis_right_x,
    :controller_axis_right_y,
    :controller_axis_trigger_left,
    :controller_axis_trigger_right,
    :controller_axis_max
  ).freeze
end

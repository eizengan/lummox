# frozen_string_literal: true

module Lummox::SDL::Core::Events
  ControllerAxis = enum(
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

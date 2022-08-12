# frozen_string_literal: true

module Lummox::SDL::Core::GameController
  # rubocop:disable Naming/VariableNumber

  GameControllerButton = Lummox::SDL::Core.enum(
    :controller_button_invalid, -1,
    :controller_button_a,
    :controller_button_b,
    :controller_button_x,
    :controller_button_y,
    :controller_button_back,
    :controller_button_guide,
    :controller_button_start,
    :controller_button_left_stick,
    :controller_button_right_stick,
    :controller_button_left_shoulder,
    :controller_button_right_shoulder,
    :controller_button_dpad_up,
    :controller_button_dpad_down,
    :controller_button_dpad_left,
    :controller_button_dpad_right,
    :controller_button_misc_1,
    :controller_button_paddle_1,
    :controller_button_paddle_2,
    :controller_button_paddle_3,
    :controller_button_paddle_4,
    :controller_button_touchpad,
    :controller_button_max
  ).freeze

  # rubocop:enable Naming/VariableNumber
end

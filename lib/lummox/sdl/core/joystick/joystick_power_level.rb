# frozen_string_literal: true

module Lummox::SDL::Core::Joystick
  JoystickPowerLevel = Lummox::SDL::Core.enum(
    :joystick_power_unknown = -1,
    :joystick_power_empty,
    :joystick_power_low,
    :joystick_power_medium,
    :joystick_power_full,
    :joystick_power_wired,
    :joystick_power_max
  ).freeze
end

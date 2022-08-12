# frozen_string_literal: true

# TODO:
# - SDL_JoystickGetDeviceGUID
# - SDL_JoystickGetGUID
# - SDL_JoystickGetGUIDFromString
# - SDL_JoystickGetGUIDString
# IGNORE:
# - SDL_JoystickEventState - just use event_state
# - SDL_JoystickUpdate - just pump events usuing the event methods
module Lummox::SDL::Core::Joystick
  HAT_CENTERED   = 0x00
  HAT_UP         = 0x01
  HAT_RIGHT      = 0x02
  HAT_DOWN       = 0x04
  HAT_LEFT       = 0x08
  HAT_RIGHT_UP   = (HAT_RIGHT | HAT_UP).freeze
  HAT_RIGHT_DOWN = (HAT_RIGHT | HAT_DOWN).freeze
  HAT_LEFT_UP    = (HAT_LEFT | HAT_UP).freeze
  HAT_LEFT_DOWN  = (HAT_LEFT | HAT_DOWN).freeze

  def self.included(base)
    base.class_eval do
      attach_sdl_function :joystick_open, [:int], :joystick_pointer # nil if error
      attach_sdl_function :joystick_close, [:joystick_pointer], :void
      attach_sdl_function :joystick_from_instance_id, [:joystick_id], :joystick_pointer, sdl_method_name: :SDL_JoystickFromInstanceID # nil if error
      attach_sdl_function :joystick_instance_id, [:joystick_pointer], :joystick_id, sdl_method_name: :SDL_JoystickInstanceID # negative if error
      attach_sdl_function :num_joysticks, [], :int # negative if error
      attach_sdl_function :joystick_get_attached, [:joystick_pointer], :bool # false may have error
      attach_sdl_function :joystick_name, [:joystick_pointer], :string # nil may have error
      attach_sdl_function :joystick_name_for_index, [:int], :string # nil may have error
      attach_sdl_function :joystick_current_power_level, [:joystick_pointer], JoystickPowerLevel
      attach_sdl_function :joystick_get_axis, %i[joystick_pointer int], :int16 # 0 may have error
      attach_sdl_function :joystick_num_axes, [:joystick_pointer], :int # negative if error
      attach_sdl_function :joystick_get_ball, %i[joystick_pointer int int_pointer int_pointer], :int # negative if error
      attach_sdl_function :joystick_num_balls, [:joystick_pointer], :int # negative if error
      attach_sdl_function :joystick_get_button, %i[joystick_pointer int], Lummox::SDL::Core::ButtonState
      attach_sdl_function :joystick_num_buttons, [:joystick_pointer], :int # negative if error
      attach_sdl_function :joystick_get_hat, %i[joystick_pointer int], :uint8
      attach_sdl_function :joystick_num_hats, [:joystick_pointer], :int # negative if error
    end
  end
end

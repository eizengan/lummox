# frozen_string_literal: true

# TODO:
# - SDL_GameControllerAddMapping
# - SDL_GameControllerAddMappingsFromFile
# - SDL_GameControllerAddMappingsFromRW
# - SDL_GameControllerMapping
# - SDL_GameControllerMappingForGUID
# Ignore:
# - SDL_GameControllerEventState - just use event_state
# - SDL_GameControllerUpdate - just pump events usuing the event methods
module Lummox::SDL::Core::GameController
  # rubocop:disable Layout/LineLength
  # rubocop:disable Metrics/MethodLength

  def self.included(base)
    base.class_eval do
      attach_sdl_function :game_controller_open, [:int], :game_controller_pointer # nil if error, free with game_controller_close
      attach_sdl_function :game_controller_close, [:game_controller_pointer], :void
      attach_sdl_function :game_controller_from_instance_id, [:joystick_id], :game_controller_pointer, sdl_method_name: :SDL_GameControllerFromInstanceID # nil if error
      attach_sdl_function :game_controller_get_joystick, [:game_controller_pointer], :joystick_pointer
      attach_sdl_function :game_controller_get_attached, [:game_controller_pointer], :bool
      attach_sdl_function :is_game_controller, [:int], :bool
      attach_sdl_function :game_controller_name, [:game_controller_pointer], :string
      attach_sdl_function :game_controller_name_for_index, [:int], :string
      attach_sdl_function :game_controller_get_axis, [:game_controller_pointer, GameControllerAxis], :int16 # 0 may have error
      attach_sdl_function :game_controller_get_axis_from_string, [:string], GameControllerAxis
      attach_sdl_function :game_controller_get_bind_for_axis, [:game_controller_pointer, GameControllerAxis], GameControllerButtonBind
      attach_sdl_function :game_controller_get_string_for_axis, [GameControllerAxis], :string
      attach_sdl_function :game_controller_get_button, [:game_controller_pointer, GameControllerButton], Lummox::SDL::Core::ButtonState # 0 may have error
      attach_sdl_function :game_controller_get_button_from_string, [:string], GameControllerButton
      attach_sdl_function :game_controller_get_bind_for_button, [:game_controller_pointer, GameControllerButton], GameControllerButtonBind
      attach_sdl_function :game_controller_get_string_for_button, [], :string
    end
  end

  # rubocop:enable Layout/LineLength
  # rubocop:enable Metrics/MethodLength
end

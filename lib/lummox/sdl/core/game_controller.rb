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
  def self.included(base)
    base.class_eval do
      # - attach_sdl_function :game_controller_open, [], :
      # - attach_sdl_function :game_controller_close, [], :
      # - attach_sdl_function :game_controller_from_instance_id, [], :

      # - attach_sdl_function :is_game_controller, [], :
      # - attach_sdl_function :game_controller_get_joystick, [], :

      # - attach_sdl_function :game_controller_name, [], :
      # - attach_sdl_function :game_controller_name_for_index, [], :

      # - attach_sdl_function :game_controller_get_attached, [], :

      # - attach_sdl_function :game_controller_get_axis, [], :
      # - attach_sdl_function :game_controller_get_axis_from_string, [], :
      # - attach_sdl_function :game_controller_get_bind_for_axis, [], :
      # - attach_sdl_function :game_controller_get_string_for_axis, [], :

      # - attach_sdl_function :game_controller_get_button, [], :
      # - attach_sdl_function :game_controller_get_button_from_string, [], :
      # - attach_sdl_function :game_controller_get_bind_for_button, [], :
      # - attach_sdl_function :game_controller_get_string_for_button, [], :
    end
  end
end

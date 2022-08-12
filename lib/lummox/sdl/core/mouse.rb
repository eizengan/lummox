# frozen_string_literal: true

# TODO:
# - SDL_CreateColorCursor
# - SDL_CreateCursor
module Lummox::SDL::Core::Mouse
  # rubocop:disable Layout/LineLength
  # rubocop:disable Metrics/MethodLength

  def self.included(base)
    base.class_eval do
      attach_sdl_function :capture_mouse, [:bool], :int # negative if error
      attach_sdl_function :create_system_cursor, [SystemCursor], :cursor_pointer
      attach_sdl_function :free_cursor, [:cursor_pointer], :void
      attach_sdl_function :get_cursor, [], :cursor_pointer
      attach_sdl_function :get_default_cursor, [], :cursor_pointer
      attach_sdl_function :get_global_mouse_state, %i[int_pointer int_pointer], :uint32
      attach_sdl_function :get_mouse_focus, [], :window_pointer
      attach_sdl_function :get_mouse_state, %i[int_pointer int_pointer], :uint32
      attach_sdl_function :get_relative_mouse_mode, [], :bool
      attach_sdl_function :get_relative_mouse_state, %i[int_pointer int_pointer], :uint32
      attach_sdl_function :set_cursor, [:cursor_pointer], :void
      attach_sdl_function :set_relative_mouse_mode, [:bool], :int # negative if error
      attach_sdl_function :show_cursor, [Lummox::SDL::Core::ToggleState], Lummox::SDL::Core::ToggleState # negative if error
      attach_sdl_function :warp_mouse_global, %i[int int], :void
      attach_sdl_function :warp_mouse_in_window, %i[int int], :int # negative if error
    end
  end

  # rubocop:enable Layout/LineLength
  # rubocop:enable Metrics/MethodLength
end

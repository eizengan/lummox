# frozen_string_literal: true

# TODO:
# - SDL_CreateColorCursor
# - SDL_CreateCursor
module Lummox::SDL::Mouse
  BUTTON = {
    BUTTON_LEFT: 0x01,
    BUTTON_MIDDLE: 0x2,
    BUTTON_RIGHT: 0x04,
    BUTTON_X1: 0x08, # rubocop:disable Naming/VariableNumber
    BUTTON_X2: 0x10 # rubocop:disable Naming/VariableNumber
  }.freeze

  # TODO: Move this to SDL::Touch upon implementing
  TOUCH_MOUSE_ID = 0xffffffff

  # rubocop:disable Metrics/MethodLength

  def self.included(base)
    base.class_eval do
      attach_sdl_function :capture_mouse, [:bool], :int # negative if error
      attach_sdl_function :create_system_cursor, [SystemCursor], :cursor_pointer # nil if error, free with free_cursor
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
      attach_sdl_function :show_cursor, [Lummox::SDL::ToggleState], Lummox::SDL::ToggleState # negative if error
      attach_sdl_function :warp_mouse_global, %i[int int], :int # negative if error
      attach_sdl_function :warp_mouse_in_window, %i[window_pointer int int], :void
    end
  end

  # rubocop:enable Metrics/MethodLength
end

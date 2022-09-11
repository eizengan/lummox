# frozen_string_literal: true

module Lummox::SDL::Keyboard
  KEYMOD = {
    KMOD_NONE: 0x0000,
    KMOD_LSHIFT: 0x0001,
    KMOD_RSHIFT: 0x0002,
    KMOD_SHIFT: (0x0001 | 0x0002),
    KMOD_LCTRL: 0x0040,
    KMOD_RCTRL: 0x0080,
    KMOD_CTRL: (0x0040 | 0x0080),
    KMOD_LALT: 0x0100,
    KMOD_RALT: 0x0200,
    KMOD_ALT: (0x0100 | 0x0200),
    KMOD_LGUI: 0x0400,
    KMOD_RGUI: 0x0800,
    KMOD_GUI: (0x0400 | 0x0800),
    KMOD_NUM: 0x1000,
    KMOD_CAPS: 0x2000,
    KMOD_MODE: 0x4000,
    KMOD_SCROLL: 0x8000,
    KMOD_RESERVED: 0x8000
  }.freeze

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength

  def self.included(base)
    base.class_eval do
      attach_sdl_function :get_keyboard_focus, [], :window_pointer
      attach_sdl_function :get_keyboard_state, [:int_pointer], :pointer
      attach_sdl_function :get_key_from_name, [:string], Keycode
      attach_sdl_function :get_key_from_scancode, [Scancode], Keycode
      attach_sdl_function :get_key_name, [Keycode], :string
      attach_sdl_function :get_mod_state, [], :uint32
      attach_sdl_function :get_scancode_from_key, [Keycode], Scancode
      attach_sdl_function :get_scancode_from_name, [:string], Scancode
      attach_sdl_function :get_scancode_name, [Scancode], :string
      attach_sdl_function :has_screen_keyboard_support, [], :bool
      attach_sdl_function :is_screen_keyboard_shown, [:window_pointer], :bool
      attach_sdl_function :is_text_input_active, [], :bool
      attach_sdl_function :set_mod_state, [:uint32], :void
      attach_sdl_function :set_text_input_rect, [Lummox::SDL::Geometry::Rect.by_ref], :void
      attach_sdl_function :start_text_input, [], :void
      attach_sdl_function :stop_text_input, [], :void
    end
  end

  # rubocop:enable all
end

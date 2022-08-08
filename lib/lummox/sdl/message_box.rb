# frozen_string_literal: true

module Lummox::SDL::MessageBox
  extend Lummox::SDL::Library

  SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = 0x00000001
  SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = 0x00000002

  class ButtonData < FFI::Struct
    layout *%i[
      button_flags uint32
      id           int
      text         pointer
    ]
  end

  class Color < FFI::Struct
    layout *%i[
      r uint8
      g uint8
      b uint8
    ]
  end

  ColorType = enum *%i[background text button_border button_background button_selected max]

  class ColorScheme < FFI::Struct
    layout :colors, [Color, ColorType[:max]]
  end

  SDL_MESSAGEBOX_ERROR                    = 0x00000010
  SDL_MESSAGEBOX_WARNING                  = 0x00000020
  SDL_MESSAGEBOX_INFORMATION              = 0x00000040
  SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT    = 0x00000080
  SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT    = 0x00000100

  typedef :pointer, :window_handle
  typedef :buffer_in, :button_data_array
  typedef :uint32, :message_box_flags

  class Data < FFI::Struct
    layout :message_box_flags, :message_box_flags,
           :window_handle,     :window_handle,
           :title,             :pointer,
           :message,           :pointer,
           :num_buttons,       :int,
           :buttons,           :button_data_array,
           :color_scheme,       ColorScheme.by_ref # null for system settings
  end

  attach_sdl_function :show_message_box, [Data.by_ref, Lummox::SDL::Pointers::Int], :int # negative if error
  attach_sdl_function :show_simple_message_box, %i[message_box_flags string string window_handle], :int # negative if error
end

# frozen_string_literal: true

# NEXT UP:
# - SDL_GetDisplayDPI
# - SDL_GetWindowGammaRamp
# - SDL_SetWindowGammaRamp
# - SDL_GetGrabbedWindow
# - SDL_SetWindowIcon
# - SDL_GetWindowFromID
# - SDL_GetWindowID
# - SDL_GetWindowFlags
# - SDL_GetWindowPixelFormat
# - SDL_SetWindowHitTest
# - SDL_HitTestResult
#
# - SDL_GL_CreateContext
# - SDL_GL_DeleteContext
# - SDL_GL_ExtensionSupported
# - SDL_GL_GetAttribute
# - SDL_GL_GetCurrentContext
# - SDL_GL_GetCurrentWindow
# - SDL_GL_GetDrawableSize
# - SDL_GL_GetProcAddress
# - SDL_GL_GetSwapInterval
# - SDL_GL_LoadLibrary
# - SDL_GL_MakeCurrent
# - SDL_GL_ResetAttributes
# - SDL_GL_SetAttribute
# - SDL_GL_SetSwapInterval
# - SDL_GL_SwapWindow
# - SDL_GL_UnloadLibrary
# - SDL_GLattr
# - SDL_GLcontextFlag
# - SDL_GLprofile
# IGNORE:
# - SDL_CreateWindowAndRenderer   - separate concerns
# - SDL_CreateWindowFrom          - requires existing native window
# - SDL_VideoInit                 - prefer consolidated initialization
# - SDL_VideoQuit                 - prefer consolidated initialization
# - SDL_GetWindowBrightness       - display brightness, not window; unavailable on many modern platforms
# - SDL_SetWindowBrightness       - display brightness, not window; unavailable on many modern platforms
# - SDL_GetWindowData             - what even is this?
# - SDL_SetWindowData             - what even is this?
# - SDL_GetWindowSurface          - blitting, not rendering
# - SDL_UpdateWindowSurface       - blitting, not rendering
# - SDL_UpdateWindowSurfaceRects  - blitting, not rendering
# - SDL_SetWindowInputFocus       - raise window instead; don't grab input while buried/hidden
# - SDL_GetWindowWMInfo           - driver-, and system-dependent info

module Lummox::SDL::Core::Video
  extend Lummox::SDL::Library

  # MessageBoxButtonData button_flags
  SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = 0x00000001
  SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = 0x00000002
  # MessageBoxData message_box_flags
  SDL_MESSAGEBOX_ERROR                    = 0x00000010
  SDL_MESSAGEBOX_WARNING                  = 0x00000020
  SDL_MESSAGEBOX_INFORMATION              = 0x00000040
  SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT    = 0x00000080
  SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT    = 0x00000100

  MessageBoxColorType = enum *%i[
    message_box_color_background
    message_box_color_text
    message_box_color_button_border
    message_box_color_button_background
    message_box_color_button_selected
    message_box_color_max
  ]

  # TODO: define flag constants
  class DisplayMode < FFI::Struct
    layout *%i[
      format_flags uint32
      width        int
      height       int
      refresh_rate int
      driver_data  pointer
    ]
  end

  class MessageBoxButtonData < FFI::Struct
    layout *%i[
      button_flags uint32
      id           int
      text         pointer
    ]
  end

  class MessageBoxColor < FFI::Struct
    layout *%i[
      r uint8
      g uint8
      b uint8
    ]
  end

  class MessageBoxColorScheme < FFI::Struct
    layout :colors, [Color, ColorType[:max]]
  end

  class MessageBoxData < FFI::Struct
    layout :message_box_flags, :uint32,
           :window_handle,     :pointer,
           :title,             :pointer,
           :message,           :pointer,
           :num_buttons,       :int,
           :buttons,           :buffer_in,
           :color_scheme,       ColorScheme.by_ref # null for system settings
  end

  # Displays
  attach_sdl_function :get_num_video_displays, %i[], :int # negative if error
  attach_sdl_function :get_display_name, %i[int], :string # nullptr if error
  attach_sdl_function :get_display_bounds, [:int, Lummox::SDL::Core::Rect::Rect.by_ref], :int # negative if error
  attach_sdl_function :get_display_usable_bounds, [:int, Lummox::SDL::Core::Rect::Rect.by_ref], :int # negative if error
  # Display modes
  attach_sdl_function :get_num_display_modes, %i[int], :int # negative if error
  attach_sdl_function :get_display_mode, [:int, :int, DisplayMode.by_ref], :int # negative if error
  attach_sdl_function :get_desktop_display_mode, [:int, DisplayMode.by_ref], :int # negative if error
  attach_sdl_function :get_current_display_mode, [:int, DisplayMode.by_ref], :int # negative if error
  attach_sdl_function :get_closest_display_mode, [:int, DisplayMode.by_ref, DisplayMode.by_ref], DisplayMode.by_ref # null if error
  # Message boxes
  attach_sdl_function :show_message_box, [MessageBoxData.by_ref, Lummox::SDL::Core::Helpers::IntPtr], :int # negative if error
  attach_sdl_function :show_simple_message_box, %i[uint32 string string pointer], :int # negative if error















end

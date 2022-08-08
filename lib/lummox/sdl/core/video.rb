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
  extend Lummox::SDL::Core::Library

  # MessageBoxButtonData button_flags
  SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = 0x00000001
  SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = 0x00000002
  # MessageBoxData message_box_flags
  SDL_MESSAGEBOX_ERROR                    = 0x00000010
  SDL_MESSAGEBOX_WARNING                  = 0x00000020
  SDL_MESSAGEBOX_INFORMATION              = 0x00000040
  SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT    = 0x00000080
  SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT    = 0x00000100
  # Window flags
  #   Fullscreen Flags
  SDL_WINDOW_FULLSCREEN         = 0x00000001
  SDL_WINDOW_FULLSCREEN_DESKTOP = SDL_WINDOW_FULLSCREEN | 0x00000010
  #   Other capabilities
  SDL_WINDOW_OPENGL             = 0x00000002
  SDL_WINDOW_VULKAN             = 0x10000000
  SDL_WINDOW_SHOWN              = 0x00000004
  SDL_WINDOW_HIDDEN             = 0x00000008
  SDL_WINDOW_BORDERLESS         = 0x00000010
  SDL_WINDOW_RESIZABLE          = 0x00000020
  SDL_WINDOW_MINIMIZED          = 0x00000040
  SDL_WINDOW_MAXIMIZED          = 0x00000080
  SDL_WINDOW_MOUSE_GRABBED      = 0x00000100
  SDL_WINDOW_INPUT_GRABBED      = SDL_WINDOW_MOUSE_GRABBED
  SDL_WINDOW_INPUT_FOCUS        = 0x00000200
  SDL_WINDOW_MOUSE_FOCUS        = 0x00000400
  SDL_WINDOW_FOREIGN            = 0x00000800
  SDL_WINDOW_ALLOW_HIGHDPI      = 0x00002000
  SDL_WINDOW_MOUSE_CAPTURE      = 0x00004000
  # SDL_WINDOW_ALWAYS_ON_TOP      = 0x00008000 # x11 only
  # SDL_WINDOW_SKIP_TASKBAR       = 0x00010000 # x11 only
  # SDL_WINDOW_UTILITY            = 0x00020000 # x11 only
  # SDL_WINDOW_TOOLTIP            = 0x00040000 # x11 only
  # SDL_WINDOW_POPUP_MENU         = 0x00080000 # x11 only

  MessageBoxColorType = enum *%i[
    message_box_color_background
    message_box_color_text
    message_box_color_button_border
    message_box_color_button_background
    message_box_color_button_selected
    message_box_color_max
  ]

  WindowFlashOperation = enum %i[
    flash_cancel
    flash_briefly
    flash_until_focused
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
    layout :colors, [
      Lummox::SDL::Core::Video::MessageBoxColor,
      Lummox::SDL::Core::Video::MessageBoxColorType[:message_box_color_max]
    ]
  end

  class MessageBoxData < FFI::Struct
    layout :message_box_flags, :uint32,
           :window_handle,     :pointer,
           :title,             :pointer,
           :message,           :pointer,
           :num_buttons,       :int,
           :buttons,           :pointer,
           :color_scheme,       Lummox::SDL::Core::Video::MessageBoxColorScheme.by_ref # null for system settings
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
  # Drivers
  attach_sdl_function :get_num_video_drivers, %i[], :int # negative if error
  attach_sdl_function :get_current_video_driver, %i[], :string
  attach_sdl_function :get_video_driver, %i[int], :string
  # Message boxes
  attach_sdl_function :show_message_box, [MessageBoxData.by_ref, Lummox::SDL::Core::Helpers::IntPtr], :int # negative if error
  attach_sdl_function :show_simple_message_box, %i[uint32 string string pointer], :int # negative if error
  # Windows
  #   Creation, ownership
  attach_sdl_function :create_window, %i[string int int int int uint32], :pointer # nil if error
  attach_sdl_function :destroy_window, %i[pointer], :void
  attach_sdl_function :set_window_modal_for, %i[pointer pointer], :int # negative if error
  #   Display, display mode
  attach_sdl_function :get_window_display_index, %i[pointer], :int
  attach_sdl_function :get_window_display_mode, [:pointer, DisplayMode.by_ref], :int # negative if error
  attach_sdl_function :set_window_display_mode, [:pointer, DisplayMode.by_ref], :int # negative if error
  #   Title
  attach_sdl_function :get_window_title, %i[pointer], :string
  attach_sdl_function :set_window_title, %i[pointer string], :void
  #   Position
  attach_sdl_function :get_window_position, %i[pointer int_pointer int_pointer], :void
  attach_sdl_function :set_window_position, %i[pointer int int], :void
  #   Size
  attach_sdl_function :set_window_resizable, %i[pointer bool], :void
  attach_sdl_function :get_window_size, %i[pointer int_pointer int_pointer], :void
  attach_sdl_function :set_window_size, %i[pointer int int], :void
  attach_sdl_function :minimize_window, %i[pointer], :void
  attach_sdl_function :maximize_window, %i[pointer], :void
  attach_sdl_function :restore_window, %i[pointer], :void
  attach_sdl_function :get_window_maximum_size, %i[pointer int_pointer int_pointer], :void
  attach_sdl_function :set_window_maximum_size, %i[pointer int int], :void
  attach_sdl_function :get_window_minimum_size, %i[pointer int_pointer int_pointer], :void
  attach_sdl_function :set_window_minimum_size, %i[pointer int int], :void
  attach_sdl_function :get_window_borders_size, %i[pointer int_pointer int_pointer int_pointer int_pointer], :int # negative if error
  #   Fullscreen, borders, presence, opacity, flashing
  attach_sdl_function :set_window_fullscreen, %i[pointer uint32], :int # negative if error
  attach_sdl_function :set_window_bordered, %i[pointer bool], :void
  attach_sdl_function :hide_window, %i[pointer], :void
  attach_sdl_function :show_window, %i[pointer], :void
  attach_sdl_function :raise_window, %i[pointer], :void
  attach_sdl_function :get_window_opacity, %i[pointer float_pointer], :int # negative if error
  attach_sdl_function :set_window_opacity, %i[pointer float], :int # negative if error
  attach_sdl_function :flash_window, [:pointer, WindowFlashOperation], :int # negative if error
  #   Screen saver
  attach_sdl_function :disable_screen_saver, %i[], :void
  attach_sdl_function :enable_screen_saver, %i[], :void
  attach_sdl_function :is_screen_saver_enabled, %i[], :bool
  #   Input grabbing
  attach_sdl_function :get_window_grab, %i[pointer], :bool
  attach_sdl_function :set_window_grab, %i[pointer bool], :void
end

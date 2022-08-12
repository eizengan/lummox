# frozen_string_literal: true

# NEXT UP:
# - SDL_GetWindowFromID
# - SDL_GetWindowID
#
# - SDL_GetDisplayDPI
# - SDL_GetWindowGammaRamp
# - SDL_SetWindowGammaRamp
# - SDL_GetGrabbedWindow
# - SDL_SetWindowIcon
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
  # Window flags
  #   Position flags
  WINDOW_POS_UNDEFINED      = 0x1FFF0000
  WINDOW_POS_CENTERED       = 0x2FFF0000
  #   Fullscreen Flags
  WINDOW_FULLSCREEN         = 0x00000001
  WINDOW_FULLSCREEN_DESKTOP = (WINDOW_FULLSCREEN | 0x00000010).freeze
  #   Other capabilities
  WINDOW_OPENGL             = 0x00000002
  WINDOW_VULKAN             = 0x10000000
  WINDOW_SHOWN              = 0x00000004
  WINDOW_HIDDEN             = 0x00000008
  WINDOW_BORDERLESS         = 0x00000010
  WINDOW_RESIZABLE          = 0x00000020
  WINDOW_MINIMIZED          = 0x00000040
  WINDOW_MAXIMIZED          = 0x00000080
  WINDOW_MOUSE_GRABBED      = 0x00000100
  WINDOW_INPUT_GRABBED      = WINDOW_MOUSE_GRABBED
  WINDOW_INPUT_FOCUS        = 0x00000200
  WINDOW_MOUSE_FOCUS        = 0x00000400
  WINDOW_FOREIGN            = 0x00000800
  WINDOW_ALLOW_HIGHDPI      = 0x00002000
  WINDOW_MOUSE_CAPTURE      = 0x00004000
  WINDOW_ALWAYS_ON_TOP      = 0x00008000 # x11 only
  WINDOW_SKIP_TASKBAR       = 0x00010000 # x11 only
  WINDOW_UTILITY            = 0x00020000 # x11 only
  WINDOW_TOOLTIP            = 0x00040000 # x11 only
  WINDOW_POPUP_MENU         = 0x00080000 # x11 only

  # rubocop:disable Layout/LineLength

  def self.included(base)
    base.class_eval do
      # Displays
      attach_sdl_function :get_num_video_displays, [], :int # negative if error
      attach_sdl_function :get_display_name, [:int], :string # nullptr if error
      attach_sdl_function :get_display_bounds, [:int, Lummox::SDL::Core::Rect::Rect.by_ref], :int # negative if error
      attach_sdl_function :get_display_usable_bounds, [:int, Lummox::SDL::Core::Rect::Rect.by_ref], :int # negative if error
      # Display modes
      attach_sdl_function :get_num_display_modes, [:int], :int # negative if error
      attach_sdl_function :get_display_mode, [:int, :int, DisplayMode.by_ref], :int # negative if error
      attach_sdl_function :get_desktop_display_mode, [:int, DisplayMode.by_ref], :int # negative if error
      attach_sdl_function :get_current_display_mode, [:int, DisplayMode.by_ref], :int # negative if error
      attach_sdl_function :get_closest_display_mode, [:int, DisplayMode.by_ref, DisplayMode.by_ref], DisplayMode.by_ref # null if error
      # Drivers
      attach_sdl_function :get_num_video_drivers, [], :int # negative if error
      attach_sdl_function :get_current_video_driver, [], :string
      attach_sdl_function :get_video_driver, [:int], :string
      # Windows
      #   Creation, ownership
      attach_sdl_function :create_window, %i[string int int int int uint32], :window_pointer # nil if error
      attach_sdl_function :destroy_window, [:window_pointer], :void
      attach_sdl_function :set_window_modal_for, %i[window_pointer window_pointer], :int # negative if error
      #   Display, display mode
      attach_sdl_function :get_window_display_index, [:window_pointer], :int
      attach_sdl_function :get_window_display_mode, [:window_pointer, DisplayMode.by_ref], :int # negative if error
      attach_sdl_function :set_window_display_mode, [:window_pointer, DisplayMode.by_ref], :int # negative if error
      #   Title
      attach_sdl_function :get_window_title, [:window_pointer], :string
      attach_sdl_function :set_window_title, %i[window_pointer string], :void
      #   Position
      attach_sdl_function :get_window_position, %i[window_pointer int_pointer int_pointer], :void
      attach_sdl_function :set_window_position, %i[window_pointer int int], :void
      #   Size
      attach_sdl_function :set_window_resizable, %i[window_pointer bool], :void
      attach_sdl_function :get_window_size, %i[window_pointer int_pointer int_pointer], :void
      attach_sdl_function :set_window_size, %i[window_pointer int int], :void
      attach_sdl_function :minimize_window, [:window_pointer], :void
      attach_sdl_function :maximize_window, [:window_pointer], :void
      attach_sdl_function :restore_window, [:window_pointer], :void
      attach_sdl_function :get_window_maximum_size, %i[window_pointer int_pointer int_pointer], :void
      attach_sdl_function :set_window_maximum_size, %i[window_pointer int int], :void
      attach_sdl_function :get_window_minimum_size, %i[window_pointer int_pointer int_pointer], :void
      attach_sdl_function :set_window_minimum_size, %i[window_pointer int int], :void
      attach_sdl_function :get_window_borders_size, %i[window_pointer int_pointer int_pointer int_pointer int_pointer], :int # negative if error
      #   Fullscreen, borders, presence, opacity, flashing
      attach_sdl_function :set_window_fullscreen, %i[window_pointer uint32], :int # negative if error
      attach_sdl_function :set_window_bordered, %i[window_pointer bool], :void
      attach_sdl_function :hide_window, [:window_pointer], :void
      attach_sdl_function :show_window, [:window_pointer], :void
      attach_sdl_function :raise_window, [:window_pointer], :void
      attach_sdl_function :get_window_opacity, %i[window_pointer float_pointer], :int # negative if error
      attach_sdl_function :set_window_opacity, %i[window_pointer float], :int # negative if error
      attach_sdl_function :flash_window, [:window_pointer, FlashOperation], :int # negative if error
      #   Screen saver
      attach_sdl_function :disable_screen_saver, [], :void
      attach_sdl_function :enable_screen_saver, [], :void
      attach_sdl_function :is_screen_saver_enabled, [], :bool
      #   Input grabbing
      attach_sdl_function :get_window_grab, [:window_pointer], :bool
      attach_sdl_function :set_window_grab, %i[window_pointer bool], :void
    end
  end

  # rubocop:enable Layout/LineLength
end

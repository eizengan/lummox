# frozen_string_literal: true

module Lummox::SDL::Window
  extend Lummox::SDL::Library

  SDL_WINDOW_FULLSCREEN         = 0x00000001
  SDL_WINDOW_FULLSCREEN_DESKTOP = SDL_WINDOW_FULLSCREEN | 0x00000010
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

  typedef :pointer, :handle
  typedef :int, :display_index
  typedef :int, :video_driver_index
  typedef :uint32, :fullscreen_flags

  enum :flash_operation, %i[cancel flash_briefly flash_until_focused]

  #   Creation, ownership
  attach_sdl_function :create_window, %i[string int int int int uint32], :handle # nil if error
  attach_sdl_function :destroy_window, %i[handle], :void
  attach_sdl_function :set_window_modal_for, %i[handle handle] # negative if error
  #                                           child ^   ^ parent
  #   Display, display mode
  attach_sdl_function :get_window_display_index, %i[handle], :int
  attach_sdl_function :get_window_display_mode, [:handle, Lummox::SDL::Display::Mode.by_ref], :int # negative if error
  attach_sdl_function :set_window_display_mode, [:handle, Lummox::SDL::Display::Mode.by_ref], :int # negative if error
  #   Title
  attach_sdl_function :get_window_title, %i[handle], :string
  attach_sdl_function :set_window_title, %i[handle string], :void
  #   Position
  attach_sdl_function :get_window_position, %i[handle int_pointer int_pointer], :void
  attach_sdl_function :set_window_position, %i[handle int int], :void
  #   Size
  attach_sdl_function :set_window_resizable, %i[handle bool], :void
  attach_sdl_function :get_window_size, %i[handle int_pointer int_pointer], :void
  attach_sdl_function :set_window_size, %i[handle int int], :void
  attach_sdl_function :minimize_window, %i[handle], :void
  attach_sdl_function :maximize_window, %i[handle], :void
  attach_sdl_function :restore_window, %i[handle], :void
  attach_sdl_function :get_window_maximum_size, %i[handle int_pointer int_pointer], :void
  attach_sdl_function :set_window_maximum_size, %i[handle int int], :void
  attach_sdl_function :get_window_minimum_size, %i[handle int_pointer int_pointer], :void
  attach_sdl_function :set_window_minimum_size, %i[handle int int], :void
  attach_sdl_function :get_window_borders_size, %i[handle int_pointer int_pointer int_pointer int_pointer], :int # negative if error
  #   Fullscreen, borders, presence, opacity, flashing
  attach_sdl_function :set_window_fullscreen, %i[handle fullscreen_flags], :int # negative if error
  attach_sdl_function :set_window_bordered, %i[handle bool], :void
  attach_sdl_function :hide_window, %i[handle], :void
  attach_sdl_function :show_window, %i[handle], :void
  attach_sdl_function :raise_window, %i[handle], :void
  attach_sdl_function :get_window_opacity, %i[handle float_pointer], :int # negative if error
  attach_sdl_function :set_window_opacity, %i[handle float], :int # negative if error
  attach_sdl_function :flash_window, %i[handle flash_operation] # negative if error
  #   Screen saver
  attach_sdl_function :disable_screen_saver, %i[], :void
  attach_sdl_function :enable_screen_saver, %i[], :void
  attach_sdl_function :is_screen_saver_enabled, %i[], :bool
  #   Input grabbing
  attach_sdl_function :get_window_grab, %i[handle], :bool
  attach_sdl_function :set_window_grab, %i[handle bool], :void
end

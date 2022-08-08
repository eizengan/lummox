# frozen_string_literal: true

class Lummox::SDL::Display
  extend Lummox::SDL::Library

  # TODO: named format_flags
  class Mode < FFI::Struct
    layout *%i[
      format_flags uint32
      width        int
      height       int
      refresh_rate int
      driver_data  pointer
    ]
  end

  typedef :int, :display_index
  typedef :int, :mode_index

  # Displays
  attach_sdl_function :get_num_video_displays, %i[], :int # negative if error
  attach_sdl_function :get_display_name, %i[display_index], :string # nullptr if error
  # Display properties
  attach_sdl_function :get_display_bounds, [:display_index, Lummox::SDL::Rect.by_ref], :int # negative if error
  attach_sdl_function :get_display_usable_bounds, [:display_index, Lummox::SDL::Rect.by_ref], :int # negative if error
  # - SDL_GetDisplayDPI
  # Display modes
  attach_sdl_function :get_num_display_modes, %i[display_index], :int # negative if error
  attach_sdl_function :get_display_mode, [:display_index, :mode_index, Mode.by_ref], :int # negative if error
  attach_sdl_function :get_desktop_display_mode, [:display_index, Mode.by_ref], :int # negative if error
  attach_sdl_function :get_current_display_mode, [:display_index, Mode.by_ref], :int # negative if error
  attach_sdl_function :get_closest_display_mode, [:display_index, Mode.by_ref, Mode.by_ref], Mode.by_ref # null if error
  #                                                               ^ target     ^ closest     ^ closest
end

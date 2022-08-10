# frozen_string_literal: true

module Lummox::SDL::Core::Video
  # TODO: define flag constants
  class DisplayMode < FFI::Struct
    layout :format_flags, :uint32,
           :width,        :int,
           :height,       :int,
           :refresh_rate, :int,
           :driver_data,  :pointer
  end
end

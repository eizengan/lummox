# frozen_string_literal: true

module Lummox::SDL::Core::Video
  # TODO: define flag constants
  class DisplayMode < FFI::Struct
    layout :format,       :uint32,
           :w,            :int,
           :h,            :int,
           :refresh_rate, :int,
           :driver_data,  :pointer
  end
end

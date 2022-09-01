# frozen_string_literal: true

class Lummox::SDL::Core::Video::DisplayMode < Lummox::SDL::Core::Struct
  layout :format,       :uint32,
         :w,            :int,
         :h,            :int,
         :refresh_rate, :int,
         :driver_data,  :pointer
end

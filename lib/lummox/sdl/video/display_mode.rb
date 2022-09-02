# frozen_string_literal: true

class Lummox::SDL::Video::DisplayMode < Lummox::SDL::Struct
  layout :format,       :uint32,
         :w,            :int,
         :h,            :int,
         :refresh_rate, :int,
         :driver_data,  :pointer
end

# frozen_string_literal: true

class Lummox::SDL::Core::Video::DisplayMode < Lummox::SDL::Core::Struct
  layout :format,       :uint32,
         :w,            :int,
         :h,            :int,
         :refresh_rate, :int,
         :driver_data,  :pointer

  alias width w
  alias height h

  def inspect
    "#<Lummox::SDL::DisplayMode #{width}x#{height} @ #{refresh_rate}Hz>"
  end
end

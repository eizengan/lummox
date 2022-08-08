# frozen_string_literal: true

module Lummox::SDL::VideoDriver
  extend Lummox::SDL::Library

  typedef :int, :video_driver_index

  attach_sdl_function :get_num_video_drivers, %i[], :int # negative if error
  attach_sdl_function :get_current_video_driver, %i[], :string
  attach_sdl_function :get_video_driver, %i[video_driver_index], :string
end

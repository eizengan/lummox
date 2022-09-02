# frozen_string_literal: true

# NEXT UP:
# - SDL_AddTimer
# - SDL_RemoveTimer

module Lummox::SDL::Core::Timer
  def self.included(base)
    base.class_eval do
      attach_sdl_function :delay, [:uint32], :void, blocking: true
      attach_sdl_function :get_performance_counter, [], :uint64
      attach_sdl_function :get_performance_frequency, [], :uint64
      attach_sdl_function :get_ticks, [], :uint32
      attach_sdl_function :get_ticks_64, [], :uint64
    end
  end
end

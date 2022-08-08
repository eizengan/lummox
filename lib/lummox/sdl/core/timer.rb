# frozen_string_literal: true

# NEXT UP:
# - SDL_AddTimer
# - SDL_RemoveTimer

module Lummox::SDL::Core::Timer
  extend Lummox::SDL::Core::Library

  attach_sdl_function :delay, %i[uint32], :void, blocking: true
  attach_sdl_function :get_performance_counter, %i[], :uint64
  attach_sdl_function :get_performance_frequency, %i[], :uint64
  attach_sdl_function :get_ticks, %i[], :uint32
  attach_sdl_function :get_ticks_64, %i[], :uint64 # rubocop:disable Naming/VariableNumber
end

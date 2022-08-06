# frozen_string_literal: true

class Lummox::SDL::Error < StandardError
  extend Lummox::SDL::Library

  attach_sdl_function :set_error, [:string], :int
  attach_sdl_function :clear_error, [], :void
  attach_sdl_function :get_error, [], :strptr
end

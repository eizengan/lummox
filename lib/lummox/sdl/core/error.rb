# frozen_string_literal: true

module Lummox::SDL::Core::Error
  extend Lummox::SDL::Core::Library

  attach_sdl_function :set_error, [:string], :int # always returns -1 error code
  attach_sdl_function :clear_error, [], :void
  attach_sdl_function :get_error, [], :strptr
end

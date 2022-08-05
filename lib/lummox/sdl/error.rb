# frozen_string_literal: true

require "ffi"

class Lummox::SDL::Error < StandardError
  extend Lummox::SDL::Library

  attach_sdl_function :set_error, [:string], :int, visibility: :class
  attach_sdl_function :clear_error, [], :void,     visibility: :class
  attach_sdl_function :get_error, [], :strptr,     visibility: :private

  class << self
    def raise_if
      raise_current_error if yield
    end

    def raise_unless
      raise_current_error unless yield
    end

    def raise_current_error
      error_message, _pointer = get_error
      raise self, error_message
    end
  end
end

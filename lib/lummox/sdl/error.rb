# frozen_string_literal: true

require "ffi"

class Lummox::SDL::Error < StandardError
  extend FFI::Library

  ffi_lib FFI::CURRENT_PROCESS

  attach_function :sdl_get_error, :SDL_GetError, [], :strptr
  attach_function :sdl_set_error, :SDL_SetError, %i[string varargs], :int
  private :sdl_get_error, :sdl_set_error
  private_class_method :sdl_get_error, :sdl_set_error

  attach_function :clear_error, :SDL_ClearError, [], :void
  private :clear_error # Only class-level; don't pollute Error instances

  class << self
    def raise_if
      raise_current_error if yield
    end

    def raise_unless
      raise_current_error unless yield
    end

    def raise_current_error
      error_message, _pointer = sdl_get_error
      raise self, error_message
    end

    def set_error(error_message) # rubocop:disable Naming/AccessorMethodName
      sdl_set_error(error_message)
    end
  end
end

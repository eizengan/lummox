# frozen_string_literal: true

require "ffi"

class Lummox::SDL::Error < StandardError
  extend FFI::Library

  ffi_lib FFI::CURRENT_PROCESS

  attach_function :SDL_GetError, [], :strptr
  attach_function :SDL_SetError, %i[string varargs], :int
  private :SDL_GetError, :SDL_SetError
  private_class_method :SDL_GetError, :SDL_SetError

  attach_function :clear_error, :SDL_ClearError, [], :void
  private :clear_error # Only class-level; don't pollute Error instances

  class << self
    def raise_if
      raise_current_error if yield
    end

    def raise_unless
      raise_current_error unless yield
    end

    def raise
      error_message, _pointer = Foo::FFI.foo_encode(p_input, p_input.size)
      raise self, error_message
    end

    def set_error(error_message) # rubocop:disable Naming/AccessorMethodName
      SDL_SetError(error_message)
    end
  end
end

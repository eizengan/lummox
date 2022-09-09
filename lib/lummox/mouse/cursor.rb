# frozen_string_literal: true

require "ffi"
require "forwardable"

# TODO:
# - show_cursor, [Lummox::SDL::ToggleState], Lummox::SDL::ToggleState # negative if error
# IGNORE:
class Lummox::Mouse::Cursor
  SDL_CURSOR_TYPES = Set.new(Lummox::SDL::SystemCursor.symbols[0..-2]).freeze

  class << self
    def switch_to(cursor_type)
      @current = new(cursor_type)
      Lummox::SDL.set_cursor(@current.pointer)
    end

    def current
      @current ||= new(from_pointer: Lummox::SDL.get_default_cursor)
    end

    def enabled?
      Lummox::SDL.show_cursor(:query) == :enable
    end

    def enabled=(enabled)
      sdl_arg = enabled ? :enable : :disable
      Lummox::SDL.show_cursor(sdl_arg)
    end
  end

  attr_reader :pointer

  private

  def initialize(cursor_type = nil, from_pointer: nil)
    if from_pointer
      @pointer = from_pointer
    else
      sdl_cursor_type = :"system_cursor_#{cursor_type}"
      ensure_cursor_type!(sdl_cursor_type)

      @pointer = create_managed_pointer(sdl_cursor_type)
    end
  end

  def ensure_cursor_type!(sdl_cursor_type)
    return if SDL_CURSOR_TYPES.include? sdl_cursor_type

    raise Lummox::SDLError, "#{sdl_cursor_type} is not a valid SDL SystemCursor"
  end

  def create_managed_pointer(sdl_cursor_type)
    pointer = Lummox::SDLError.raise_if(:null?) { Lummox::SDL.create_system_cursor(sdl_cursor_type) }
    FFI::AutoPointer.new(pointer, method(:free_cursor))
  end

  def free_cursor
    Lummox::SDL.free_cursor(pointer)
  end
end

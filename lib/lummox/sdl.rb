# frozen_string_literal: true

require "ffi"
require_relative "sdl/zeitwerk"

module Lummox::SDL
  LIB_SDL2 = ENV.fetch("LIB_SDL2").freeze

  extend FFI::Library

  ffi_lib_flags :now, :global
  ffi_lib LIB_SDL2
end

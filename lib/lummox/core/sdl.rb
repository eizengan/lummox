# frozen_string_literal: true

require "ffi"

module Lummox::Core::SDL
  LIB_SDL2 = "/usr/local/Cellar/sdl2/2.0.22/lib/libSDL2.dylib"

  extend FFI::Library

  ffi_lib_flags :now, :global
  ffi_lib LIB_SDL2
end

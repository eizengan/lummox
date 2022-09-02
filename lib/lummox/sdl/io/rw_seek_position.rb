# frozen_string_literal: true

require "ffi"

module Lummox::SDL::IO
  RWSeekPosition = Lummox::SDL.enum(
    FFI::Type::INT,
    :rw_seek_set,
    :rw_seek_cur,
    :rw_seek_end
  ).freeze
end

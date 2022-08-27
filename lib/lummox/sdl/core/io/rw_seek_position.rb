# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::IO
  RWSeekPosition = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :rw_seek_set,
    :rw_seek_cur,
    :rw_seek_end,
  ).freeze
end

# frozen_string_literal: true

require "ffi"

module Lummox::SDL::IO
  RWOpsType = Lummox::SDL.enum(
    FFI::Type::UINT32,
    :rw_ops_unknown,
    :rw_ops_win_file,
    :rw_ops_std_file,
    :rw_ops_jni_file,
    :rw_ops_memory,
    :rw_ops_memory_ro
  ).freeze
end

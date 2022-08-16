# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Mouse
  SystemCursor = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :system_cursor_arrow,
    :system_cursor_i_beam,
    :system_cursor_wait,
    :system_cursor_crosshair,
    :system_cursor_wait_arrow,
    :system_cursor_size_nw_se,
    :system_cursor_size_ne_sw,
    :system_cursor_size_w_e,
    :system_cursor_size_n_s,
    :system_cursor_size_all,
    :system_cursor_no,
    :system_cursor_hand,
    :num_system_cursor
  ).freeze
end

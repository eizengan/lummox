# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Pixel
  PackedOrder = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :packed_order_none,
    :packed_order_xrgb,
    :packed_order_rgbx,
    :packed_order_argb,
    :packed_order_rgba,
    :packed_order_xbgr,
    :packed_order_bgrx,
    :packed_order_abgr,
    :packed_order_bgra
  ).freeze
end

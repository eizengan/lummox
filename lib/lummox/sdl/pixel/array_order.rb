# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Pixel
  ArrayOrder = Lummox::SDL.enum(
    FFI::Type::INT,
    :array_order_none,
    :array_order_rgb,
    :array_order_rgba,
    :array_order_argb,
    :array_order_bgr,
    :array_order_bgra,
    :array_order_abgr
  ).freeze
end

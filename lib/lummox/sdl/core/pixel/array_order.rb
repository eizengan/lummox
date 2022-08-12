# frozen_string_literal: true

module Lummox::SDL::Core::Pixel
  ArrayOrder = Lummox::SDL::Core.enum(
    :array_order_none,
    :array_order_rgb,
    :array_order_rgba,
    :array_order_argb,
    :array_order_bgr,
    :array_order_bgra,
    :array_order_abgr
  ).freeze
end

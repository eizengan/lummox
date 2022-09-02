# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Pixel
  BitmapOrder = Lummox::SDL.enum(
    FFI::Type::INT,
    :bitmap_order_none,
    :bitmap_order_4321,
    :bitmap_order_1234
  ).freeze
end

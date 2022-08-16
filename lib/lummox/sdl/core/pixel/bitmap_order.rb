# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Pixel
  # rubocop:disable Naming/VariableNumber

  BitmapOrder = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :bitmap_order_none,
    :bitmap_order_4321,
    :bitmap_order_1234
  ).freeze

  # rubocop:enable Naming/VariableNumber
end

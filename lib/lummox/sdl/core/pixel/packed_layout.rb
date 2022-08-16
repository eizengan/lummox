# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Pixel
  # rubocop:disable Naming/VariableNumber

  PackedLayout = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :packed_layout_none,
    :packed_layout_332,
    :packed_layout_4444,
    :packed_layout_1555,
    :packed_layout_5551,
    :packed_layout_565,
    :packed_layout_8888,
    :packed_layout_2101010,
    :packed_layout_1010102
  ).freeze

  # rubocop:enable Naming/VariableNumber
end

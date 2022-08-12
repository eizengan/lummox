# frozen_string_literal: true

module Lummox::SDL::Core::Pixel
  # rubocop:disable Naming/VariableNumber

  PixelType = Lummox::SDL::Core.enum(
    :pixel_type_unknown,
    :pixel_type_index_1,
    :pixel_type_index_4,
    :pixel_type_index_8,
    :pixel_type_packed_8,
    :pixel_type_packed_16,
    :pixel_type_packed_32,
    :pixel_type_array_u8,
    :pixel_type_array_u16,
    :pixel_type_array_u32,
    :pixel_type_array_f16,
    :pixel_type_array_f32
  ).freeze

  # rubocop:enable Naming/VariableNumber
end

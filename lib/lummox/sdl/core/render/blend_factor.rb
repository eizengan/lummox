# frozen_string_literal: true

module Lummox::SDL::Core::Render
  BlendFactor = Lummox::SDL::Core.enum(
    :blend_factor_zero,                0x1,
    :blend_factor_one,                 0x2,
    :blend_factor_src_color,           0x3,
    :blend_factor_one_minus_src_color, 0x4,
    :blend_factor_src_alpha,           0x5,
    :blend_factor_one_minus_src_alpha, 0x6,
    :blend_factor_dst_color,           0x7,
    :blend_factor_one_minus_dst_color, 0x8,
    :blend_factor_dst_alpha,           0x9,
    :blend_factor_one_minus_dst_alpha, 0xA
  ).freeze
end

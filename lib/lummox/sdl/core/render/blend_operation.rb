# frozen_string_literal: true

module Lummox::SDL::Core::Render
  BlendOperation = Lummox::SDL::Core.enum(
    :blend_operation_add,          0x1,
    :blend_operation_subtract,     0x2,
    :blend_operation_rev_subtract, 0x3,
    :blend_operation_minimum,      0x4,
    :blend_operation_maximum,      0x5
  ).freeze
end

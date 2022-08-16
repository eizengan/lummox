# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Render
  BlendMode = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :blend_mode_none,    0x00000000,
    :blend_mode_blend,   0x00000001,
    :blend_mode_add,     0x00000002,
    :blend_mode_mod,     0x00000004,
    :blend_mode_mul,     0x00000008,
    :blend_mode_invalid, 0x7FFFFFFF
  ).freeze
end

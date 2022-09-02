# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Mouse
  # TODO: This type is used by a struct, but the declaration is quite apparently int; does this work in all cases?
  # May be confounded by the fact that in the code this is defined by preprocessor, not enum
  MouseButton = Lummox::SDL::Core.enum(
    FFI::Type::UINT8,
    :button_left, 1,
    :button_middle,
    :button_right,
    :button_x1, # rubocop:disable Naming/VariableNumber
    :button_x2  # rubocop:disable Naming/VariableNumber
  ).freeze
end

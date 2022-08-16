# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Mouse
  MouseWheelDirection = Lummox::SDL::Core.enum(
    FFI::Type::UINT32,
    :mouse_wheel_normal,
    :mouse_wheel_flipped
  ).freeze
end

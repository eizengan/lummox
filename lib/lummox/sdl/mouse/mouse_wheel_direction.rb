# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Mouse
  MouseWheelDirection = Lummox::SDL.enum(
    FFI::Type::UINT32,
    :mouse_wheel_normal,
    :mouse_wheel_flipped
  ).freeze
end

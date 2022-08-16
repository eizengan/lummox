# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Video
  DisplayOrientation = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :orientation_unknown,
    :orientation_landscape,
    :orientation_landscape_flipped,
    :orientation_portrait,
    :orientation_portrait_flipped
  ).freeze
end

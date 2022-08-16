# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Render
  TextureAccess = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :texture_access_static,
    :texture_access_streaming,
    :texture_access_target
  ).freeze
end

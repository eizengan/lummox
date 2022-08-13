# frozen_string_literal: true

module Lummox::SDL::Core::Render
  TextureAccess = Lummox::SDL::Core.enum(
    :texture_access_static,
    :texture_access_streaming,
    :texture_access_target
  ).freeze
end

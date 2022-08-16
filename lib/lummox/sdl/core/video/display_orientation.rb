# frozen_string_literal: true

module Lummox::SDL::Core::Video
  DisplayOrientation = Lummox::SDL::Core.enum(
    :orientation_unknown,
    :orientation_landscape,
    :orientation_landscape_flipped,
    :orientation_portrait,
    :orientation_portrait_flipped
  ).freeze
end

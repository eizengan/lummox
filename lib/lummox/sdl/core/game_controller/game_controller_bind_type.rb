# frozen_string_literal: true

module Lummox::SDL::Core::GameController
  GameControllerBindType = Lummox::SDL::Core.enum(
    :controller_bind_type_none, 0,
    :controller_bind_type_button,
    :controller_bind_type_axis,
    :controller_bind_type_hat
  ).freeze
end

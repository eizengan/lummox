# frozen_string_literal: true

module Lummox::SDL::Core::Joystick
  HAT_CENTERED   = 0x00
  HAT_UP         = 0x01
  HAT_RIGHT      = 0x02
  HAT_DOWN       = 0x04
  HAT_LEFT       = 0x08
  HAT_RIGHT_UP   = (HAT_RIGHT | HAT_UP).freeze
  HAT_RIGHT_DOWN = (HAT_RIGHT | HAT_DOWN).freeze
  HAT_LEFT_UP    = (HAT_LEFT | HAT_UP).freeze
  HAT_LEFT_DOWN  = (HAT_LEFT | HAT_DOWN).freeze
end

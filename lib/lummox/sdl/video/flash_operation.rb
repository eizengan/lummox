# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Video
  FlashOperation = Lummox::SDL.enum(
    FFI::Type::INT,
    :flash_cancel,
    :flash_briefly,
    :flash_until_focused
  ).freeze
end

# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Video
  FlashOperation = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :flash_cancel,
    :flash_briefly,
    :flash_until_focused
  ).freeze
end

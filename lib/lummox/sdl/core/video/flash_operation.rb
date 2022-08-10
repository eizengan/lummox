# frozen_string_literal: true

module Lummox::SDL::Core::Video
  FlashOperation = Lummox::SDL::Core.enum(
    :flash_cancel,
    :flash_briefly,
    :flash_until_focused
  ).freeze
end

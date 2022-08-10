# frozen_string_literal: true

module Lummox::SDL::Core::Video
  class MessageBoxColor < FFI::Struct
    layout :r, :uint8,
           :g, :uint8,
           :b, :uint8
  end
end

# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Video
  DisplayEventId = Lummox::SDL.enum(
    FFI::Type::UINT8,
    :display_event_none,
    :display_event_orientation,
    :display_event_connected,
    :display_event_disconnected
  ).freeze
end

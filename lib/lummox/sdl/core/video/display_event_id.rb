# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Video
  DisplayEventId = Lummox::SDL::Core.enum(
    FFI::Type::UINT8,
    :display_event_none,
    :display_event_orientation,
    :display_event_connected,
    :display_event_disconnected
  ).freeze
end

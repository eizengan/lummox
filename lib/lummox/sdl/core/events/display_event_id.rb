# frozen_string_literal: true

module Lummox::SDL::Core::Events
  DisplayEventId = enum(
    :display_event_none,
    :display_event_orientation,
    :display_event_connected,
    :display_event_disconnected
  ).freeze
end

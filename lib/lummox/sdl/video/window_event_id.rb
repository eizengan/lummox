# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Video
  WindowEventId = Lummox::SDL.enum(
    FFI::Type::UINT8,
    :window_event_none,
    :window_event_shown,
    :window_event_hidden,
    :window_event_exposed,
    :window_event_moved,
    :window_event_resized,
    :window_event_size_changed,
    :window_event_minimized,
    :window_event_maximized,
    :window_event_restored,
    :window_event_enter,
    :window_event_leave,
    :window_event_focus_gained,
    :window_event_focus_lost,
    :window_event_close,
    :window_event_take_focus,
    :window_event_hit_test,
    :window_event_icc_prof_changed,
    :window_event_display_changed
  ).freeze
end

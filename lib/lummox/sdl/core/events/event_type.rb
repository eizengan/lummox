# frozen_string_literal: true

module Lummox::SDL::Core::Events
  # rubocop:disable Layout/ExtraSpacing

  # Event type
  EventType = Lummox::SDL::Core.enum(
    :first_event,                0x0000,
    :quit,                       0x0100,
    :app_terminating,
    :app_low_memory,
    :app_will_enter_background,
    :app_did_enter_background,
    :app_will_enter_foreground,
    :app_did_enter_foreground,
    :locale_changed,
    # Display events
    :display_event,              0x0150,
    # Window events
    :window_event,               0x0200,
    :sys_wm_event,
    # Keyboard events
    :key_down,                   0x0300,
    :key_up,
    :text_editing,
    :text_input,
    :keymap_changed,
    :text_editing_ext,
    # Mouse events
    :mouse_motion,               0x0400,
    :mouse_button_down,
    :mouse_button_up,
    :mouse_wheel,
    # Joystick events
    :joy_axis_motion,            0x0600,
    :joy_ball_motion,
    :joy_hat_motion,
    :joy_button_down,
    :joy_button_up,
    :joy_device_added,
    :joy_device_removed,
    :joy_battery_updated,
    # Controller events
    :controller_axis_motion,     0x0650,
    :controller_button_down,
    :controller_button_up,
    :controller_device_added,
    :controller_device_removed,
    :controller_device_remapped,
    :controller_touchpad_down,
    :controller_touchpad_motion,
    :controller_touchpad_up,
    :controller_sensor_update,
    # Touch events
    :finger_down,                0x0700,
    :finger_up,
    :finger_motion,
    # Gesture events
    :dollar_gesture,             0x0800,
    :dollar_record,
    :multi_gesture,
    # Clipboard events
    :clipboard_update,           0x0900,
    # Drag and drop events
    :drop_file,                  0x1000,
    :drop_text,
    :drop_begin,
    :drop_complete,
    # Audio hotplug events
    :audio_device_added,         0x1100,
    :audio_device_removed,
    # Sensor events
    :sensor_update,              0x1200,
    # render events
    :render_targets_reset,       0x2000,
    :render_device_reset,
    # Internal events
    :poll_sentinel,              0x7f00,
    # User-defined events
    :user_event,                 0x8000,
    # Array-end marker
    :last_event,                 0xffff
  ).freeze

  # rubocop:enable Layout/ExtraSpacing
end

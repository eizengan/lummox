# frozen_string_literal: true

module Lummox::SDL::Event
  EVENT_CLASSES_FOR_TYPE = {
    first_event: nil,
    quit: QuitEvent,
    display_event: nil,
    window_event: WindowEvent,
    key_down: KeyboardEvent,
    key_up: KeyboardEvent,
    text_editing: TextEditingEvent,
    text_input: TextInputEvent,
    mouse_motion: MouseMotionEvent,
    mouse_button_down: MouseButtonEvent,
    mouse_button_up: MouseButtonEvent,
    mouse_wheel: MouseWheelEvent,
    joy_axis_motion: nil,
    joy_ball_motion: nil,
    joy_hat_motion: nil,
    joy_button_down: nil,
    joy_button_up: nil,
    joy_device_added: nil,
    joy_device_removed: nil,
    controller_axis_motion: ControllerAxisEvent,
    controller_button_down: ControllerButtonEvent,
    controller_button_up: ControllerButtonEvent,
    controller_device_added: ControllerDeviceEvent,
    controller_device_removed: ControllerDeviceEvent,
    controller_device_remapped: ControllerDeviceEvent,
    audio_device_added: AudioDeviceEvent,
    audio_device_removed: AudioDeviceEvent,
    poll_sentinel: nil,
    last_event: nil
  }.freeze
  TYPES = Set.new(EVENT_CLASSES_FOR_TYPE.keys).freeze

  def self.from(sdl_event)
    klass = EVENT_CLASSES_FOR_TYPE[sdl_event[:type]] || CommonEvent
    klass.new(sdl_event)
  end
end

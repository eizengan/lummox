# frozen_string_literal: true

require "forwardable"

class Lummox::Event
  extend Forwardable

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
    field = klass::SDL_EVENT_FIELD
    klass.new(sdl_event, field)
  end

  attr_reader :sdl_event

  def_delegators :sdl_event, :type, :timestamp

  def inspect
    "#<#{self.class} type=#{type} timestamp=#{timestamp}>"
  end

  private

  def initialize(sdl_event, field)
    @sdl_event = sdl_event[field]
  end
end

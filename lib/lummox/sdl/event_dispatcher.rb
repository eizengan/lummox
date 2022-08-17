# frozen_string_literal: true

require "securerandom"

class Lummox::SDL::EventDispatcher
  EVENT_FIELDS_FOR_TYPE = {
    quit: :quit_event,
    display_event: :display_event,
    window_event: :window_event,
    key_down: :keyboard_event,
    key_up: :keyboard_event,
    text_editing: :text_editing_event,
    text_input: :text_input_event,
    mouse_motion: :mouse_motion_event,
    mouse_button_down: :mouse_button_event,
    mouse_button_up: :mouse_button_event,
    mouse_wheel: :mouse_wheel_event,
    joy_axis_motion: :joy_axis_event,
    joy_ball_motion: :joy_ball_event,
    joy_hat_motion: :joy_hat_event,
    joy_button_down: :joy_button_event,
    joy_button_up: :joy_button_event,
    joy_device_added: :joy_device_event,
    joy_device_removed: :joy_device_event,
    controller_axis_motion: :controller_axis_event,
    controller_button_down: :controller_button_event,
    controller_button_up: :controller_button_event,
    controller_device_added: :controller_device_event,
    controller_device_removed: :controller_device_event,
    controller_device_remapped: :controller_device_event,
    audio_device_added: :audio_device_event,
    audio_device_removed: :audio_device_event
  }.freeze

  @instance = nil

  class << self
    def instance
      @instance ||= new
    end

    def add_event_listener(type, &event_listener)
      instance.add_event_listener(type, &event_listener)
    end

    def remove_event_listener(event_listener_id)
      instance.remove_event_listener(event_listener_id)
    end

    def dispatch_events
      instance.dispatch_events
    end
  end

  def add_event_listener(type, &event_listener)
    event_listener_id = SecureRandom.uuid
    @event_listeners[event_listener_id] = [type, event_listener]
    (@type_map[type] ||= []) << event_listener_id
    event_listener_id
  end

  def remove_event_listener(event_listener_id)
    type, _event_listener = @event_listeners.delete(event_listener_id)
    @type_map[type].delete(event_listener_id)
  end

  def dispatch_events
    dispatch_next_event while Lummox::SDL::Core.poll_event(@next_event).nonzero?
  end

  private

  def initialize
    @next_event = Lummox::SDL::Core::Event.new
    @event_listeners = {}
    @type_map = {}
  end

  def dispatch_next_event
    @type_map[@next_event[:type]]&.map { |event_listener_id| @event_listeners[event_listener_id] }
                                 &.each { |type, event_listener| event_listener.call(typed_next_event) }
  end

  def typed_next_event
    event_field = EVENT_FIELDS_FOR_TYPE[@next_event[:type]] || :common_event
    @next_event[event_field]
  end
end

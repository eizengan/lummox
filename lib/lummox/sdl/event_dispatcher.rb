# frozen_string_literal: true

require "securerandom"

class Lummox::SDL::EventDispatcher
  @instance = nil

  class << self
    def instance
      @instance ||= new
    end

    def add_event_listener(type, &event_listener)
      raise Lummox::SDL::Error, "Unknown event type #{type}" unless Lummox::SDL::Event::TYPES.include?(type)

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
    @event_listeners[event_listener_id] = event_listener
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
    typed_event = Lummox::SDL::Event.from(@next_event.clone)
    @type_map[@next_event[:type]]&.map { |event_listener_id| @event_listeners[event_listener_id] }
                                 &.each { |event_listener| event_listener.call(typed_event) }
  end
end

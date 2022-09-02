# frozen_string_literal: true

require "forwardable"
require "securerandom"
require "singleton"

class Lummox::EventDispatcher
  include Singleton
  extend SingleForwardable

  def_delegators :instance, :add_event_listener, :remove_event_listener, :dispatch_events

  def initialize
    @next_sdl_event = Lummox::SDL::Core::Event.new
    @event_listeners = {}
    @type_map = {}
  end

  def add_event_listener(type, &event_listener)
    raise Lummox::SDLError, "Unknown event type #{type}" unless Lummox::Event::TYPES.include?(type)

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
    dispatch_next_event while Lummox::SDL::Core.poll_event(@next_sdl_event).nonzero?
  end

  private

  def dispatch_next_event
    event_listener_ids = @type_map[@next_sdl_event[:type]]
    event_listeners = event_listener_ids&.map { |event_listener_id| @event_listeners[event_listener_id] }

    typed_event = Lummox::Event.from(@next_sdl_event.clone)
    event_listeners&.each { |event_listener| event_listener.call(typed_event) }
  end
end

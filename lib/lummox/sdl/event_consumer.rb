# frozen_string_literal: true

module Lummox::SDL::EventConsumer
  def event_listener_ids
    @event_listener_ids ||= Set.new
  end

  def add_event_listener(type, &listener)
    event_listener_ids&.add(Lummox::SDL::EventDispatcher.add_event_listener(type, &listener))
  end

  def remove_event_listener(event_listener_id)
    Lummox::SDL::EventDispatcher.remove_event_listener(event_listener_id)
    event_listener_ids&.delete(event_listener_id)
  end

  def remove_all_event_listeners
    event_listener_ids&.each { |event_listener_id| remove_event_listener(event_listener_id) }
  end
end

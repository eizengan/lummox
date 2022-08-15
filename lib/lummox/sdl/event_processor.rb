# frozen_string_literal: true

# TODO: This is a DRAFT - flesh it out a little, add some sugar
class Lummox::SDL::EventProcessor
  attr_reader :last_processed_event

  def initialize
    @last_processed_event = Lummox::SDL::Core::Event.new
    @listeners = {}
  end

  def process_events
    dispatch_event(last_processed_event) while Lummox::SDL::Core.poll_event(last_processed_event).nonzero?
  end

  def listen_for(type, &listener)
    (@listeners[type] ||= []) << listener
  end

  private

  def dispatch_event(event)
    @listeners[event[:type]]&.each { |l| l.call(event) }
  end
end

# frozen_string_literal: true

# rubocop:disable Naming/VariableNumber

class Lummox::SDL::Event::WindowEvent
  EVENT_IDS = Set.new(Lummox::SDL::Core::WindowEventId.symbols).freeze

  extend Lummox::SDL::Event::Helpers

  delegate_to_event :window_id
  delegate_to_event :event, alias_as: :event_id

  def initialize(sdl_event)
    @event = sdl_event[:window_event]
  end

  def window
    Lummox::SDL::Window.from_id(window_id)
  end

  # TRICKY: Create helper methods to check for a particular event id, e.g.:
  # - for :window_event_close call `WindowEvent#close?`
  # - for :window_event_moved call `WindowEvent#moved?`
  EVENT_IDS.each do |event_id|
    event_id_suffix = event_id.match(/window_event_(.*)/)[1]
    event_id_check_method = :"#{event_id_suffix}?"
    define_method(event_id_check_method) { self.event_id == event_id }
  end

  def x
    return unless moved?

    event[:data_1]
  end

  def y
    return unless moved?

    event[:data_2]
  end

  def width
    return unless resized? || size_changed?

    event[:data_1]
  end

  def height
    return unless resized? || size_changed?

    event[:data_2]
  end

  def inspect
    event_description = "event_id=#{event_id}"
    event_description += " x=#{x} y=#{y}" if moved?
    event_description += " width=#{width} height=#{height}" if resized? || size_changed?

    "#<#{self.class} #{event_description}>"
  end
end

# rubocop:enable Naming/VariableNumber

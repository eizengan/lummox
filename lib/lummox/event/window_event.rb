# frozen_string_literal: true

class Lummox::Event::WindowEvent < Lummox::Event
  SDL_EVENT_FIELD = :window_event
  EVENT_IDS = Set.new(Lummox::SDL::WindowEventId.symbols).freeze

  def_delegator :sdl_event, :event, :event_id
  def_delegator :sdl_event, :window_id

  def window
    @window ||= Lummox::Window.from_id(window_id)
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

    sdl_event[:data_1]
  end

  def y
    return unless moved?

    sdl_event[:data_2]
  end

  def width
    return unless resized? || size_changed?

    sdl_event[:data_1]
  end

  def height
    return unless resized? || size_changed?

    sdl_event[:data_2]
  end

  def inspect
    event_description = "event_id=#{event_id}"
    event_description += " x=#{x} y=#{y}" if moved?
    event_description += " width=#{width} height=#{height}" if resized? || size_changed?

    "#<#{self.class} #{event_description}>"
  end
end

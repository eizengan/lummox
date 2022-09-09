# frozen_string_literal: true

class Lummox::Event::TextEditingEvent < Lummox::Event
  SDL_EVENT_FIELD = :text_editing_event

  def_delegators :sdl_event, :window_id, :text, :start, :length

  def window
    @window ||= Lummox::Window.from_id(window_id)
  end

  def inspect
    "#<#{self.class} text=#{text} start=#{start} length=#{length}>"
  end
end

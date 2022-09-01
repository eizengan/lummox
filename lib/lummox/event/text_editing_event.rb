# frozen_string_literal: true

class Lummox::Event::TextEditingEvent
  extend Lummox::Event::Helpers

  delegate_to_event :window_id
  delegate_to_event :text
  delegate_to_event :start
  delegate_to_event :length

  def initialize(sdl_event)
    @sdl_event = sdl_event[:text_editing_event]
  end

  def window
    Lummox::Window.from_id(window_id)
  end

  def inspect
    "#<#{self.class} text=#{text} start=#{start} length=#{length}>"
  end
end

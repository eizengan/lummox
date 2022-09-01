# frozen_string_literal: true

class Lummox::Event::TextInputEvent
  extend Lummox::Event::Helpers

  delegate_to_event :window_id
  delegate_to_event :text

  def initialize(sdl_event)
    @sdl_event = sdl_event[:text_input_event]
  end

  def window
    Lummox::Window.from_id(window_id)
  end

  def inspect
    "#<#{self.class} text=#{text}>"
  end
end

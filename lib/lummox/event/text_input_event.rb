# frozen_string_literal: true

class Lummox::Event::TextInputEvent < Lummox::Event
  SDL_EVENT_FIELD = :text_input_event

  def_delegators :@sdl_event, :window_id, :text

  def window
    Lummox::Window.from_id(window_id)
  end

  def inspect
    "#<#{self.class} text=#{text}>"
  end
end

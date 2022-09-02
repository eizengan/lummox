# frozen_string_literal: true

class Lummox::Event::QuitEvent < Lummox::Event
  SDL_EVENT_FIELD = :quit_event

  def inspect
    "#<#{self.class} timestamp=#{timestamp}>"
  end
end

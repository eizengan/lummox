# frozen_string_literal: true

class Lummox::SDL::Event::QuitEvent
  include Lummox::SDL::Event::Helpers

  def initialize(sdl_event)
    @event = sdl_event[:quit_event]
  end

  def inspect
    "#<#{self.class} timestamp=#{timestamp}>"
  end
end

# frozen_string_literal: true

class Lummox::Event::QuitEvent
  extend Lummox::Event::Helpers

  def initialize(sdl_event)
    @sdl_event = sdl_event[:quit_event]
  end

  def inspect
    "#<#{self.class} timestamp=#{timestamp}>"
  end
end

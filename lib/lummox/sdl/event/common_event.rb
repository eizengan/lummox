# frozen_string_literal: true

class Lummox::SDL::Event::CommonEvent
  include Lummox::SDL::Event::Helpers

  def initialize(sdl_event)
    @event = sdl_event[:common_event]
  end

  def inspect
    "#<Lummox::SDL::Event::CommonEvent type=#{type} timestamp=#{timestamp}>"
  end
end

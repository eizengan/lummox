# frozen_string_literal: true

class Lummox::Event::CommonEvent
  extend Lummox::Event::Helpers

  def initialize(sdl_event)
    @sdl_event = sdl_event[:common_event]
  end

  def inspect
    "#<#{self.class} type=#{type} timestamp=#{timestamp}>"
  end
end

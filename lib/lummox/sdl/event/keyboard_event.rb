# frozen_string_literal: true

class Lummox::SDL::Event::KeyboardEvent
  include Lummox::SDL::Event::Helpers

  delegate_to_event :window_id
  delegate_to_event :state
  delegate_to_event :repeat
  delegate_to_event :keysym

  def initialize(sdl_event)
    @event = sdl_event[:keyboard_event]
  end

  def window
    Lummox::SDL::Window.from_id(window_id)
  end

  def pressed?
    state == :pressed
  end

  def keycode
    keysym[:sym]
  end

  def scancode
    keysym[:scancode]
  end

  def inspect
    "#<#{self.class} type=#{type} keycode=#{keycode} scancode=#{scancode}>"
  end
end

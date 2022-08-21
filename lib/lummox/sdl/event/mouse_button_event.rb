# frozen_string_literal: true

class Lummox::SDL::Event::MouseButtonEvent
  include Lummox::SDL::Event::Helpers

  delegate_to_event :window_id
  delegate_to_event :which, alias_as: :mouse_id
  delegate_to_event :button
  delegate_to_event :state
  delegate_to_event :clicks
  delegate_to_event :x
  delegate_to_event :y

  def initialize(sdl_event)
    @event = sdl_event[:mouse_button_event]
  end

  def window
    Lummox::SDL::Window.from_id(window_id)
  end

  def touch?
    mouse_id == Lummox::SDL::Core::Mouse::TOUCH_MOUSE_ID
  end

  def pressed?
    state == :pressed
  end

  def inspect
    "#<Lummox::SDL::Event::MouseButtonEvent type=#{type} window_id=#{window_id} button=#{button} x=#{x} y=#{y}>"
  end
end

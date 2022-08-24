# frozen_string_literal: true

class Lummox::SDL::Event::MouseMotionEvent
  extend Lummox::SDL::Event::Helpers

  delegate_to_event :window_id
  delegate_to_event :which, alias_as: :mouse_id
  delegate_to_event :state
  delegate_to_event :x
  delegate_to_event :y
  delegate_to_event :x_rel
  delegate_to_event :y_rel

  def initialize(sdl_event)
    @event = sdl_event[:mouse_motion_event]
  end

  def window
    Lummox::SDL::Window.from_id(window_id)
  end

  def touch?
    mouse_id == Lummox::SDL::Core::Mouse::TOUCH_MOUSE_ID
  end

  def inspect
    "#<#{self.class} window_id=#{window_id} x=#{x} y=#{y}>"
  end
end

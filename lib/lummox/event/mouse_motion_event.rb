# frozen_string_literal: true

class Lummox::Event::MouseMotionEvent < Lummox::Event
  SDL_EVENT_FIELD = :mouse_motion_event

  def_delegator :@sdl_event, :which, :mouse_id
  def_delegators :@sdl_event, :window_id, :state, :x, :y, :x_rel, :y_rel

  def window
    Lummox::Window.from_id(window_id)
  end

  def touch?
    mouse_id == Lummox::SDL::Mouse::TOUCH_MOUSE_ID
  end

  def inspect
    "#<#{self.class} window_id=#{window_id} x=#{x} y=#{y}>"
  end
end

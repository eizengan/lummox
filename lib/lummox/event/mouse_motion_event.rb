# frozen_string_literal: true

class Lummox::Event::MouseMotionEvent < Lummox::Event
  SDL_EVENT_FIELD = :mouse_motion_event

  def_delegator :@sdl_event, :which, :mouse_id
  def_delegators :@sdl_event, :window_id, :state

  def window
    @window ||= Lummox::Window.from_id(window_id)
  end

  def touch?
    mouse_id == Lummox::SDL::Mouse::TOUCH_MOUSE_ID
  end

  def relative?
    @relative ||= Lummox::Mouse.relative?
  end

  def x
    if relative?
      @sdl_event.x_rel
    else
      @sdl_event.x
    end
  end

  def y
    if relative?
      @sdl_event.y_rel
    else
      @sdl_event.y
    end
  end

  def inspect
    "#<#{self.class} window_id=#{window_id} relative=#{relative?} x=#{x} y=#{y}>"
  end
end

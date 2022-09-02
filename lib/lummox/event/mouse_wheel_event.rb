# frozen_string_literal: true

class Lummox::Event::MouseWheelEvent < Lummox::Event
  SDL_EVENT_FIELD = :mouse_wheel_event

  def_delegator :@sdl_event, :which, :mouse_id
  def_delegators :@sdl_event, :window_id, :x, :direction, :precise_x

  def window
    Lummox::Window.from_id(window_id)
  end

  def touch?
    mouse_id == Lummox::SDL::Core::Mouse::TOUCH_MOUSE_ID
  end

  def y
    -@sdl_event.y
  end

  def precise_y
    -@sdl_event.precise_y
  end

  def inspect
    "#<#{self.class} window_id=#{window_id} x=#{x} y=#{y}>"
  end
end

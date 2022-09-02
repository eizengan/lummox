# frozen_string_literal: true

class Lummox::Event::MouseWheelEvent < Lummox::Event
  SDL_EVENT_FIELD = :mouse_wheel_event

  def_delegator :@sdl_event, :which, :mouse_id
  def_delegators :@sdl_event, :window_id, :x, :y, :direction, :precise_x, :precise_y

  def window
    Lummox::Window.from_id(window_id)
  end

  def touch?
    mouse_id == Lummox::SDL::Core::Mouse::TOUCH_MOUSE_ID
  end

  def dx
    directionize(x)
  end

  def dy
    directionize(y)
  end

  def precise_dx
    directionize(precise_x)
  end

  def precise_dy
    directionize(precise_y)
  end

  def inspect
    "#<#{self.class} window_id=#{window_id} dx=#{dx} dy=#{dy}>"
  end

  private

  def directionize(value)
    case direction
    when :mouse_wheel_normal
      value
    when :mouse_wheel_flipped
      -value
    else
      raise Lummox::SDLError, "Unknown MouseWheelDirection #{direction}"
    end
  end
end

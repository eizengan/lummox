# frozen_string_literal: true

class Lummox::SDL::Event::MouseWheelEvent
  include Lummox::SDL::Event::Helpers

  delegate_to_event :window_id
  delegate_to_event :which, alias_as: :mouse_id
  delegate_to_event :x
  delegate_to_event :y
  delegate_to_event :direction
  delegate_to_event :precise_x
  delegate_to_event :precise_y

  def initialize(sdl_event)
    @event = sdl_event[:mouse_wheel_event]
  end

  def window
    Lummox::SDL::Window.from_id(window_id)
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
    "#<Lummox::SDL::Event::MouseWheelEvent window_id=#{window_id} dx=#{dx} dy=#{dy}>"
  end

  private

  def directionize(value)
    case direction
    when :mouse_wheel_normal
      value
    when :mouse_wheel_flipped
      -value
    else
      raise Lummox::SDL::Error, "Unknown MouseWheelDirection #{direction}"
    end
  end
end

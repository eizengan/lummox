# frozen_string_literal: true

class Lummox::Event::MouseButtonEvent < Lummox::Event
  SDL_EVENT_FIELD = :mouse_button_event

  def_delegator :@sdl_event, :which, :mouse_id
  def_delegators :@sdl_event, :window_id, :button, :state, :clicks, :x, :y

  def window
    Lummox::Window.from_id(window_id)
  end

  def touch?
    mouse_id == Lummox::SDL::Core::Mouse::TOUCH_MOUSE_ID
  end

  def pressed?
    state == :pressed
  end

  def inspect
    "#<#{self.class} type=#{type} window_id=#{window_id} button=#{button} x=#{x} y=#{y}>"
  end
end

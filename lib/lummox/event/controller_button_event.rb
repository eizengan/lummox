# frozen_string_literal: true

class Lummox::Event::ControllerButtonEvent < Lummox::Event
  SDL_EVENT_FIELD = :controller_button_event

  def_delegator :sdl_event, :which, :joystick_instance_id
  def_delegators :sdl_event, :button, :state

  def controller
    @controller ||= Lummox::Controller.from_instance_id(joystick_instance_id)
  end

  def pressed?
    state == :pressed
  end

  def inspect
    "#<#{self.class} type=#{type} joystick_instance_id=#{joystick_instance_id} button=#{button} state=#{state}>"
  end
end

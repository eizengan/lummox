# frozen_string_literal: true

class Lummox::Event::ControllerAxisEvent < Lummox::Event
  SDL_EVENT_FIELD = :controller_axis_event

  def_delegator :sdl_event, :which, :joystick_instance_id
  def_delegators :sdl_event, :axis, :value

  def controller
    @controller ||= Lummox::Controller.from_instance_id(joystick_instance_id)
  end

  def inspect
    "#<#{self.class} joystick_instance_id=#{joystick_instance_id} axis=#{axis} value=#{value}>"
  end
end

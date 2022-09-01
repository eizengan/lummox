# frozen_string_literal: true

class Lummox::Event::ControllerAxisEvent
  extend Lummox::Event::Helpers

  delegate_to_event :which, alias_as: :joystick_instance_id
  delegate_to_event :axis
  delegate_to_event :value

  def initialize(sdl_event)
    @sdl_event = sdl_event[:controller_axis_event]
  end

  def controller
    Lummox::Controller.from_instance_id(joystick_instance_id)
  end

  def inspect
    "#<#{self.class} joystick_instance_id=#{joystick_instance_id} axis=#{axis} value=#{value}>"
  end
end

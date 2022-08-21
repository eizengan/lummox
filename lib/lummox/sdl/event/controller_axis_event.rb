# frozen_string_literal: true

class Lummox::SDL::Event::ControllerAxisEvent
  include Lummox::SDL::Event::Helpers

  delegate_to_event :which, alias_as: :joystick_instance_id
  delegate_to_event :axis
  delegate_to_event :value

  def initialize(sdl_event)
    @event = sdl_event[:controller_axis_event]
  end

  def game_controller
    Lummox::SDL::GameController.from_instance_id(joystick_instance_id)
  end

  def inspect
    "#<Lummox::SDL::Event::ControllerAxisEvent joystick_instance_id=#{joystick_instance_id} axis=#{axis} value=#{value}>"
  end
end

# frozen_string_literal: true

class Lummox::SDL::Event::ControllerButtonEvent
  extend Lummox::SDL::Event::Helpers

  delegate_to_event :which, alias_as: :joystick_instance_id
  delegate_to_event :button
  delegate_to_event :state

  def initialize(sdl_event)
    @event = sdl_event[:controller_button_event]
  end

  def game_controller
    Lummox::SDL::GameController.from_instance_id(joystick_instance_id)
  end

  def pressed?
    state == :pressed
  end

  def inspect
    "#<#{self.class} type=#{type} joystick_instance_id=#{joystick_instance_id} button=#{button} state=#{state}>"
  end
end

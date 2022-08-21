# frozen_string_literal: true

class Lummox::SDL::Event::ControllerButtonEvent
  include Lummox::SDL::Event::Helpers

  delegate_to_event :which, alias_as: :joystick_id
  delegate_to_event :button
  delegate_to_event :state

  def initialize(sdl_event)
    @event = sdl_event[:controller_button_event]
  end

  def pressed?
    state == :pressed
  end

  def inspect
    "#<Lummox::SDL::Event::ControllerButtonEvent type=#{type} joystick_id=#{joystick_id} button=#{button} state=#{state}>"
  end
end

# frozen_string_literal: true

class Lummox::SDL::Event::ControllerAxisEvent
  include Lummox::SDL::Event::Helpers

  delegate_to_event :which, alias_as: :joystick_id
  delegate_to_event :axis
  delegate_to_event :value

  def initialize(sdl_event)
    @event = sdl_event[:controller_axis_event]
  end

  def inspect
    "#<Lummox::SDL::Event::ControllerAxisEvent joystick_id=#{joystick_id} axis=#{axis} value=#{value}>"
  end
end

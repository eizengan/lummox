# frozen_string_literal: true

class Lummox::SDL::Event::ControllerDeviceEvent
  include Lummox::SDL::Event::Helpers

  delegate_to_event :which, alias_as: :joystick_id

  def initialize(sdl_event)
    @event = sdl_event[:controller_device_event]
  end

  def inspect
    "#<Lummox::SDL::Event::ControllerDeviceEvent type=#{type} joystick_id=#{joystick_id}>"
  end
end

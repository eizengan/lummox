# frozen_string_literal: true

class Lummox::Event::ControllerDeviceEvent
  extend Lummox::Event::Helpers

  def initialize(sdl_event)
    @sdl_event = sdl_event[:controller_device_event]
  end

  def joystick_index
    raise Lummox::SDLError, "No joystick_index for type '#{type}'" unless type == :controller_device_added

    sdl_event[:which]
  end

  def joystick_instance_id
    raise Lummox::SDLError, "No joystick_instance_id for type '#{type}'" if type == :controller_device_added

    sdl_event[:which]
  end

  def controller
    Lummox::Controller.from_instance_id(joystick_instance_id)
  end

  def inspect
    identifier_details = if type == :controller_device_added
                           "joystick_index=#{joystick_index}"
                         else
                           "joystick_instance_id=#{joystick_instance_id}"
                         end
    "#<#{self.class} type=#{type} #{identifier_details}>"
  end
end

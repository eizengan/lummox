# frozen_string_literal: true

class Lummox::SDL::Event::ControllerDeviceEvent
  include Lummox::SDL::Event::Helpers

  def initialize(sdl_event)
    @event = sdl_event[:controller_device_event]
  end

  def joystick_index
    raise Lummox::SDL::Error, "No joystick_index for type '#{type}'" unless type == :controller_device_added

    event[:which]
  end

  def joystick_instance_id
    raise Lummox::SDL::Error, "No joystick_instance_id for type '#{type}'" if type == :controller_device_added

    event[:which]
  end

  def game_controller
    Lummox::SDL::GameController.from_instance_id(joystick_instance_id)
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

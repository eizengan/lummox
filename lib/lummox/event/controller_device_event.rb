# frozen_string_literal: true

class Lummox::Event::ControllerDeviceEvent < Lummox::Event
  SDL_EVENT_FIELD = :controller_device_event

  def joystick_index
    return sdl_event[:which] if type == :controller_device_added

    raise Lummox::SDLError, "No joystick_index for type '#{type}'"
  end

  def joystick_instance_id
    return sdl_event[:which] unless type == :controller_device_added

    raise Lummox::SDLError, "No joystick_instance_id for type 'controller_device_added'"
  end

  def controller
    return nil if type == :controller_device_added

    @controller ||= Lummox::Controller.from_instance_id(joystick_instance_id)
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

# frozen_string_literal: true

class Lummox::Event::AudioDeviceEvent < Lummox::Event
  SDL_EVENT_FIELD = :audio_device_event

  def_delegator :sdl_event, :which, :index

  def device_type
    case sdl_event[:is_capture]
    when 1
      :capture
    when 0
      :output
    else
      :unknown
    end
  end

  def capture?
    device_type == :capture
  end

  def output?
    device_type == :output
  end

  def inspect
    "#<#{self.class} type=#{type} index=#{index} device_type=#{device_type}>"
  end
end

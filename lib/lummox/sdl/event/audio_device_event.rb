# frozen_string_literal: true

class Lummox::SDL::Event::AudioDeviceEvent
  include Lummox::SDL::Event::Helpers

  delegate_to_event :which, alias_as: :index

  def initialize(sdl_event)
    @event = sdl_event[:audio_device_event]
  end

  def device_type
    case event[:is_capture]
    when 1
      :capture
    when 0
      :output
    else
      :unknown
    end
  end

  def capture?
    event[:is_capture] == 1
  end

  def output?
    event[:is_capture] == 0
  end

  def inspect
    "#<Lummox::SDL::Event::AudioDeviceEvent type=#{type} index=#{index} device_type=#{device_type}>"
  end
end

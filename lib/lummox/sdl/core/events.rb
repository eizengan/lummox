# frozen_string_literal: true

# DEFER:
# - SDL_JoyAxisEvent
# - SDL_JoyBallEvent
# - SDL_JoyButtonEvent
# - SDL_JoyDeviceEvent
# - SDL_JoyHatEvent
# - SDL_DropEvent
# - SDL_SysWMEvent
# - SDL_UserEvent
# - SDL_SensorEvent
#
# - SDL_AddEventWatch
# - SDL_DelEventWatch
# - SDL_FilterEvents
# - SDL_GetEventFilter
# - SDL_SetEventFilter
# - SDL_PeepEvents
#
# - SDL_DollarGestureEvent
# - SDL_Finger
# - SDL_TouchFingerEvent
# - SDL_MultiGestureEvent
# - SDL_GetNumTouchDevices
# - SDL_GetNumTouchFingers
# - SDL_GetTouchDevice
# - SDL_GetTouchFinger
# - SDL_LoadDollarTemplates
# - SDL_RecordGesture
# - SDL_SaveAllDollarTemplates
# - SDL_SaveDollarTemplate
# IGNORE:
# - SDL_GetEventState - defined by preprocessor macro
# - SDL_QuitRequested - defined by preprocessor macro

module Lummox::SDL::Core::Events
  def self.included(base)
    base.class_eval do
      attach_sdl_function :event_state, [EventType, Lummox::SDL::Core::ToggleState], Lummox::SDL::Core::ToggleState
      attach_sdl_function :flush_event, [EventType], :void
      attach_sdl_function :flush_events, [EventType, EventType], :void
      attach_sdl_function :has_event, [EventType], :bool
      attach_sdl_function :has_events, [EventType, EventType], :bool
      attach_sdl_function :poll_event, [Event.by_ref], :int
      attach_sdl_function :pump_events, [], :void
      attach_sdl_function :push_event, [Event.by_ref], :int # negative if error
      attach_sdl_function :register_events, [:int], :uint32
      attach_sdl_function :wait_event, [Event.by_ref], :int # 0 if error
      attach_sdl_function :wait_event_timeout, [Event.by_ref, :int], :int # 0 if error or timeout elapsed
    end
  end
end

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
  extend Lummox::SDL::Core::Library

  # Keymod buttons
  KEYMOD_NONE     = 0x0000
  KEYMOD_LSHIFT   = 0x0001
  KEYMOD_RSHIFT   = 0x0002
  KEYMOD_SHIFT    = (0x0001 | 0x0002).freeze
  KEYMOD_LCTRL    = 0x0040
  KEYMOD_RCTRL    = 0x0080
  KEYMOD_CTRL     = (0x0040 | 0x0080).freeze
  KEYMOD_LALT     = 0x0100
  KEYMOD_RALT     = 0x0200
  KEYMOD_ALT      = (0x0100 | 0x0200).freeze
  KEYMOD_LGUI     = 0x0400
  KEYMOD_RGUI     = 0x0800
  KEYMOD_GUI      = (0x0400 | 0x0800).freeze
  KEYMOD_NUM      = 0x1000
  KEYMOD_CAPS     = 0x2000
  KEYMOD_MODE     = 0x4000
  KEYMOD_SCROLL   = 0x8000
  KEYMOD_RESERVED = 0x8000

  ButtonState = enum(*%i[released pressed])
  EventState = enum(:query, -1, :disable, :enable)
  MouseButton = enum(:button_left, 1, :button_middle, :button_right, :button_x1, :button_x2)
  MouseWheelDirection = enum(*%i[normal flipped])

  class Event < FFI::Union
    layout :type,                    Lummox::SDL::Core::Events::EventType,
           :common_event,            Lummox::SDL::Core::Events::CommonEvent,
           :display_event,           Lummox::SDL::Core::Events::DisplayEvent,
           :window_event,            Lummox::SDL::Core::Events::WindowEvent,
           :keyboard_event,          Lummox::SDL::Core::Events::KeyboardEvent,
           :text_editing_event,      Lummox::SDL::Core::Events::TextEditingEvent,
           :text_input_event,        Lummox::SDL::Core::Events::TextInputEvent,
           :mouse_motion_event,      Lummox::SDL::Core::Events::MouseMotionEvent,
           :mouse_button_event,      Lummox::SDL::Core::Events::MouseButtonEvent,
           :mouse_wheel_event,       Lummox::SDL::Core::Events::MouseWheelEvent,
           :controller_axis_event,   Lummox::SDL::Core::Events::ControllerAxisEvent,
           :controller_button_event, Lummox::SDL::Core::Events::ControllerButtonEvent,
           :controller_device_event, Lummox::SDL::Core::Events::ControllerDeviceEvent,
           :audio_device_event,      Lummox::SDL::Core::Events::AudioDeviceEvent,
           :quit_event,              Lummox::SDL::Core::Events::QuitEvent
  end

  attach_sdl_function :event_state, [EventType, EventState], EventState
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

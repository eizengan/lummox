# frozen_string_literal: true

# NEXT UP:
# - SDL_AudioDeviceEvent
# - SDL_ControllerAxisEvent
# - SDL_ControllerButtonEvent
# - SDL_ControllerDeviceEvent
# - SDL_DollarGestureEvent
# - SDL_DropEvent
# - SDL_Finger
# - SDL_JoyAxisEvent
# - SDL_JoyBallEvent
# - SDL_JoyButtonEvent
# - SDL_JoyDeviceEvent
# - SDL_JoyHatEvent
# - SDL_MultiGestureEvent
# - SDL_SensorEvent
# - SDL_SysWMEvent
# - SDL_TouchFingerEvent
# - SDL_UserEvent
#
# - SDL_FilterEvents
# - SDL_FlushEvent
# - SDL_FlushEvents
# - SDL_GetEventFilter
# - SDL_GetEventState
# - SDL_GetNumTouchDevices
# - SDL_GetNumTouchFingers
# - SDL_GetTouchDevice
# - SDL_GetTouchFinger
# - SDL_HasEvent
# - SDL_HasEvents
# - SDL_LoadDollarTemplates
# - SDL_PeepEvents
# - SDL_PollEvent
# - SDL_PumpEvents
# - SDL_PushEvent
# - SDL_QuitRequested
# - SDL_RecordGesture
# - SDL_RegisterEvents
# - SDL_SaveAllDollarTemplates
# - SDL_SaveDollarTemplate
# - SDL_SetEventFilter
# - SDL_WaitEvent
# - SDL_WaitEventTimeout
# DEFER:
# - SDL_AddEventWatch
# - SDL_DelEventWatch

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
    layout :window_event,       Lummox::SDL::Core::Events::WindowEvent,
           :keyboard_event,     Lummox::SDL::Core::Events::KeyboardEvent,
           :mouse_motion_event, Lummox::SDL::Core::Events::MouseMotionEvent,
           :mouse_button_event, Lummox::SDL::Core::Events::MouseButtonEvent,
           :mouse_wheel_event,  Lummox::SDL::Core::Events::MouseWheelEvent,
           :quit_event,         Lummox::SDL::Core::Events::QuitEvent,
           :text_editing_event, Lummox::SDL::Core::Events::TextEditingEvent,
           :text_input_event,   Lummox::SDL::Core::Events::TextInputEvent
  end
end

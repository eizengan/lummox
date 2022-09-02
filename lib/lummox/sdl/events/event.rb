# frozen_string_literal: true

class Lummox::SDL::Events::Event < FFI::Union
  layout :type,                    Lummox::SDL::Events::EventType,
         :common_event,            Lummox::SDL::Events::CommonEvent,
         :display_event,           Lummox::SDL::Events::DisplayEvent,
         :window_event,            Lummox::SDL::Events::WindowEvent,
         :keyboard_event,          Lummox::SDL::Events::KeyboardEvent,
         :text_editing_event,      Lummox::SDL::Events::TextEditingEvent,
         :text_input_event,        Lummox::SDL::Events::TextInputEvent,
         :mouse_motion_event,      Lummox::SDL::Events::MouseMotionEvent,
         :mouse_button_event,      Lummox::SDL::Events::MouseButtonEvent,
         :mouse_wheel_event,       Lummox::SDL::Events::MouseWheelEvent,
         :joy_axis_event,          Lummox::SDL::Events::JoyAxisEvent,
         :joy_ball_event,          Lummox::SDL::Events::JoyBallEvent,
         :joy_button_event,        Lummox::SDL::Events::JoyButtonEvent,
         :joy_device_event,        Lummox::SDL::Events::JoyDeviceEvent,
         :joy_hat_event,           Lummox::SDL::Events::JoyHatEvent,
         :controller_axis_event,   Lummox::SDL::Events::ControllerAxisEvent,
         :controller_button_event, Lummox::SDL::Events::ControllerButtonEvent,
         :controller_device_event, Lummox::SDL::Events::ControllerDeviceEvent,
         :audio_device_event,      Lummox::SDL::Events::AudioDeviceEvent,
         :quit_event,              Lummox::SDL::Events::QuitEvent
end

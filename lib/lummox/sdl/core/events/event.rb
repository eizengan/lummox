# frozen_string_literal: true

class Lummox::SDL::Core::Events::Event < FFI::Union
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
         :joy_axis_event,          Lummox::SDL::Core::Events::JoyAxisEvent,
         :joy_ball_event,          Lummox::SDL::Core::Events::JoyBallEvent,
         :joy_button_event,        Lummox::SDL::Core::Events::JoyButtonEvent,
         :joy_device_event,        Lummox::SDL::Core::Events::JoyDeviceEvent,
         :joy_hat_event,           Lummox::SDL::Core::Events::JoyHatEvent,
         :controller_axis_event,   Lummox::SDL::Core::Events::ControllerAxisEvent,
         :controller_button_event, Lummox::SDL::Core::Events::ControllerButtonEvent,
         :controller_device_event, Lummox::SDL::Core::Events::ControllerDeviceEvent,
         :audio_device_event,      Lummox::SDL::Core::Events::AudioDeviceEvent,
         :quit_event,              Lummox::SDL::Core::Events::QuitEvent
end

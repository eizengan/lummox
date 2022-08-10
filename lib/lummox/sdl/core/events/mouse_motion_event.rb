# frozen_string_literal: true

class Lummox::SDL::Core::Events::MouseMotionEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :which,     :uint32,
         :button,    Lummox::SDL::Core::Mouse::MouseButton,
         :state,     :uint32,
         :x,         :int32,
         :y,         :int32,
         :x_rel,     :int32,
         :y_rel,     :int32
end

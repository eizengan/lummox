# frozen_string_literal: true

class Lummox::SDL::Events::MouseMotionEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :which,     :uint32,
         :state,     :uint32,
         :x,         :int32,
         :y,         :int32,
         :x_rel,     :int32,
         :y_rel,     :int32
end

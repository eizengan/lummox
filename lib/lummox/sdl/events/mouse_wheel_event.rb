# frozen_string_literal: true

class Lummox::SDL::Events::MouseWheelEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :which,     :uint32,
         :x,         :int32,
         :y,         :int32,
         :direction, Lummox::SDL::Mouse::MouseWheelDirection,
         :precise_x, :float,
         :precise_y, :float
end

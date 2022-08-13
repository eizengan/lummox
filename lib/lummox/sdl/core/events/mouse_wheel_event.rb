# frozen_string_literal: true

class Lummox::SDL::Core::Events::MouseWheelEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :which,     :uint32,
         :x,         :int32,
         :y,         :int32,
         :direction, Lummox::SDL::Core::Mouse::MouseWheelDirection,
         :precise_x, :float,
         :precise_y, :float
end

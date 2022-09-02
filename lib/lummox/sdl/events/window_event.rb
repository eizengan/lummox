# frozen_string_literal: true

class Lummox::SDL::Events::WindowEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :event,     Lummox::SDL::Video::WindowEventId,
         :padding_1, :uint8,
         :padding_2, :uint8,
         :padding_3, :uint8,
         :data_1,    :int32,
         :data_2,    :int32
end

# frozen_string_literal: true

class Lummox::SDL::Core::Events::WindowEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :event,     Lummox::SDL::Core::Video::WindowEventId,
         :padding_1, :uint8,
         :padding_2, :uint8,
         :padding_3, :uint8,
         :data_1,    :int32,
         :data_2,    :int32
end

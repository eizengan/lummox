# frozen_string_literal: true

class Lummox::SDL::Events::DisplayEvent < Lummox::SDL::Struct
  layout :type,       Lummox::SDL::Events::EventType,
         :timestamp,  :uint32,
         :display_id, :uint32,
         :event,      Lummox::SDL::Video::DisplayEventId,
         :data_1,     :int32
end

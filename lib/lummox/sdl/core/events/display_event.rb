# frozen_string_literal: true

class Lummox::SDL::Core::Events::DisplayEvent < Lummox::SDL::Core::Struct
  layout :type,       Lummox::SDL::Core::Events::EventType,
         :timestamp,  :uint32,
         :display_id, :uint32,
         :event,      Lummox::SDL::Core::Video::DisplayEventId,
         :data_1,     :int32
end

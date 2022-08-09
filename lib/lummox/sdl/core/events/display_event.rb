# frozen_string_literal: true

class Lummox::SDL::Core::Events::DisplayEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :display,   :uint32,
         :event,     Lummox::SDL::Core::Events::DisplayEventId,
         :padding_1, :uint8,
         :padding_2, :uint8,
         :padding_3, :uint8,
         :data1,     :int32
end

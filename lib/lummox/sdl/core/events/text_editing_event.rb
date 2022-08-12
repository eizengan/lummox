# frozen_string_literal: true

class Lummox::SDL::Core::Events::TextEditingEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :window_id,
         :text,      [:char, 32],
         :start,     :int32,
         :length,    :int32
end

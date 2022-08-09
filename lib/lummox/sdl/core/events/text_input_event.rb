# frozen_string_literal: true

class Lummox::SDL::Core::Events::TextInputEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :text,      [:char, 32]
end

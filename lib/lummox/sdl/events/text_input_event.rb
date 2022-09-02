# frozen_string_literal: true

class Lummox::SDL::Events::TextInputEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :text,      [:char, 32]
end

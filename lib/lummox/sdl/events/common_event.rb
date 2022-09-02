# frozen_string_literal: true

class Lummox::SDL::Events::CommonEvent < Lummox::SDL::Struct
  layout :type,      Lummox::SDL::Events::EventType,
         :timestamp, :uint32
end

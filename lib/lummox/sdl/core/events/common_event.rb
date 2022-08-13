# frozen_string_literal: true

class Lummox::SDL::Core::Events::CommonEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32
end

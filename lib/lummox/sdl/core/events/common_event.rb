# frozen_string_literal: true

class Lummox::SDL::Core::Events::CommonEvent < FFI::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32
end

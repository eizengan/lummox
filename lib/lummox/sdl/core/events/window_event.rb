# frozen_string_literal: true

class Lummox::SDL::Core::Events::WindowEvent < Lummox::SDL::Core::Struct
  layout :type,      Lummox::SDL::Core::Events::EventType,
         :timestamp, :uint32,
         :window_id, :uint32,
         :event,     Lummox::SDL::Core::Video::WindowEventId,
         :padding1,  :uint8,
         :padding2,  :uint8,
         :padding3,  :uint8,
         :data_1,    :int32, # rubocop:disable Naming/VariableNumber
         :data_2,    :int32  # rubocop:disable Naming/VariableNumber
end

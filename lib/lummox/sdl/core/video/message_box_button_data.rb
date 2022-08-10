# frozen_string_literal: true

module Lummox::SDL::Core::Video
  class MessageBoxButtonData < FFI::Struct
    layout :button_flags, :uint32,
           :id,           :int,
           :text,         :pointer
  end
end

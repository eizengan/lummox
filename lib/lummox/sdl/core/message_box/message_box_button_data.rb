# frozen_string_literal: true

module Lummox::SDL::Core::MessageBox
  class MessageBoxButtonData < FFI::Struct
    layout :flags,     :uint32,
           :button_id, :int,
           :text,      :pointer
  end
end

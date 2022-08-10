# frozen_string_literal: true

module Lummox::SDL::Core::Video
  class MessageBoxData < FFI::Struct
    layout :message_box_flags, :uint32,
           :window_handle,     :pointer,
           :title,             :pointer,
           :message,           :pointer,
           :num_buttons,       :int,
           :buttons,           :pointer,
           :color_scheme,      Lummox::SDL::Core::Video::MessageBoxColorScheme.by_ref # null for system settings
  end
end

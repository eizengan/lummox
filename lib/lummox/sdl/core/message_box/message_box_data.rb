# frozen_string_literal: true

module Lummox::SDL::Core::MessageBox
  class MessageBoxData < FFI::Struct
    layout :flags,        :uint32,
           :window,       :window_pointer,
           :title,        :pointer,
           :message,      :pointer,
           :num_buttons,  :int,
           :buttons,      :pointer,
           :color_scheme, Lummox::SDL::Core::MessageBox::MessageBoxColorScheme.by_ref # null for system settings
  end
end

# frozen_string_literal: true

class Lummox::SDL::Core::MessageBox::MessageBoxData < Lummox::SDL::Core::Struct
  layout :flags,        :uint32,
         :window,       :pointer,
         :title,        :pointer,
         :message,      :pointer,
         :num_buttons,  :int,
         :buttons,      :pointer,
         :color_scheme, Lummox::SDL::Core::MessageBox::MessageBoxColorScheme.by_ref # null for system settings
end

# frozen_string_literal: true

class Lummox::SDL::MessageBox::MessageBoxData < Lummox::SDL::Struct
  layout :flags,        :uint32,
         :window,       :pointer,
         :title,        :pointer,
         :message,      :pointer,
         :num_buttons,  :int,
         :buttons,      :pointer,
         :color_scheme, Lummox::SDL::MessageBox::MessageBoxColorScheme.by_ref # null for system settings
end

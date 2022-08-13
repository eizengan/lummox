# frozen_string_literal: true

class Lummox::SDL::Core::MessageBox::MessageBoxButtonData < Lummox::SDL::Core::Struct
  layout :flags,     :uint32,
         :button_id, :int,
         :text,      :pointer
end

# frozen_string_literal: true

class Lummox::SDL::MessageBox::MessageBoxButtonData < Lummox::SDL::Struct
  layout :flags,     :uint32,
         :button_id, :int,
         :text,      :pointer
end

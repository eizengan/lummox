# frozen_string_literal: true

class Lummox::SDL::Core::MessageBox::MessageBoxColor < Lummox::SDL::Core::Struct
  layout :r, :uint8,
         :g, :uint8,
         :b, :uint8
end

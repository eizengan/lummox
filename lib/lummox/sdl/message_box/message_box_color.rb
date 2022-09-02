# frozen_string_literal: true

class Lummox::SDL::MessageBox::MessageBoxColor < Lummox::SDL::Struct
  layout :r, :uint8,
         :g, :uint8,
         :b, :uint8
end

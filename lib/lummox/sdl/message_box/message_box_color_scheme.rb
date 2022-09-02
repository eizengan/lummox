# frozen_string_literal: true

class Lummox::SDL::MessageBox::MessageBoxColorScheme < Lummox::SDL::Struct
  color_array = [
    Lummox::SDL::MessageBox::MessageBoxColor,
    Lummox::SDL::MessageBox::MessageBoxColorType[:message_box_color_max]
  ]

  layout :colors, color_array
end

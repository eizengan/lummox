# frozen_string_literal: true

class Lummox::SDL::Core::MessageBox::MessageBoxColorScheme < Lummox::SDL::Core::Struct
  color_array = [
    Lummox::SDL::Core::MessageBox::MessageBoxColor,
    Lummox::SDL::Core::MessageBox::MessageBoxColorType[:message_box_color_max]
  ]

  layout :colors, color_array
end

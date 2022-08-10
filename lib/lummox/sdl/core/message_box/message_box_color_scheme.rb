# frozen_string_literal: true

module Lummox::SDL::Core::MessageBox
  class MessageBoxColorScheme < FFI::Struct
    color_array = [
      Lummox::SDL::Core::MessageBox::MessageBoxColor,
      Lummox::SDL::Core::MessageBox::MessageBoxColorType[:message_box_color_max]
    ]

    layout :colors, color_array
  end
end

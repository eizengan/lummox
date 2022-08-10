# frozen_string_literal: true

module Lummox::SDL::Core::Video
  class MessageBoxColorScheme < FFI::Struct
    color_array = [
      Lummox::SDL::Core::Video::MessageBoxColor,
      Lummox::SDL::Core::Video::MessageBoxColorType[:message_box_color_max]
    ]

    layout :colors, color_array
  end
end

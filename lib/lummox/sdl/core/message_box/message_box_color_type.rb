# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::MessageBox
  MessageBoxColorType = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :message_box_color_background,
    :message_box_color_text,
    :message_box_color_button_border,
    :message_box_color_button_background,
    :message_box_color_button_selected,
    :message_box_color_max
  ).freeze
end

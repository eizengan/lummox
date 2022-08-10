# frozen_string_literal: true

module Lummox::SDL::Core::MessageBox
  MessageBoxColorType = Lummox::SDL::Core.enum(
    :message_box_color_background,
    :message_box_color_text,
    :message_box_color_button_border,
    :message_box_color_button_background,
    :message_box_color_button_selected,
    :message_box_color_max
  ).freeze
end

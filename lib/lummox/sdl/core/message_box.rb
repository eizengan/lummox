# frozen_string_literal: true

module Lummox::SDL::Core::MessageBox
  # MessageBoxButtonData button_flags
  MESSAGE_BOX_BUTTON_RETURNKEY_DEFAULT = 0x00000001
  MESSAGE_BOX_BUTTON_ESCAPEKEY_DEFAULT = 0x00000002
  # MessageBoxData message_box_flags
  MESSAGE_BOX_ERROR                    = 0x00000010
  MESSAGE_BOX_WARNING                  = 0x00000020
  MESSAGE_BOX_INFORMATION              = 0x00000040
  MESSAGE_BOX_BUTTONS_LEFT_TO_RIGHT    = 0x00000080
  MESSAGE_BOX_BUTTONS_RIGHT_TO_LEFT    = 0x00000100

  # rubocop:disable Layout/LineLength

  def self.included(base)
    base.class_eval do
      attach_sdl_function :show_message_box, [MessageBoxData.by_ref, Lummox::SDL::Core::IntPtr], :int # negative if error
      attach_sdl_function :show_simple_message_box, %i[uint32 string string window_pointer], :int # negative if error
    end
  end

  # rubocop:enable Layout/LineLength
end

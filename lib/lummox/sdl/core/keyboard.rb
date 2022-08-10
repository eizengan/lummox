# frozen_string_literal: true

# TODO:
# - SDL_GetKeyboardFocus
# - SDL_GetKeyboardState
# - SDL_GetKeyFromName
# - SDL_GetKeyFromScancode
# - SDL_GetKeyName
# - SDL_GetModState
# - SDL_GetScancodeFromKey
# - SDL_GetScancodeFromName
# - SDL_GetScancodeName
# - SDL_HasScreenKeyboardSupport
# - SDL_IsScreenKeyboardShown
# - SDL_IsTextInputActive
# - SDL_SetModState
# - SDL_SetTextInputRect
# - SDL_StartTextInput
# - SDL_StopTextInput

module Lummox::SDL::Core::Keyboard
  # Keymod buttons
  KEYMOD_NONE     = 0x0000
  KEYMOD_LSHIFT   = 0x0001
  KEYMOD_RSHIFT   = 0x0002
  KEYMOD_SHIFT    = (0x0001 | 0x0002).freeze
  KEYMOD_LCTRL    = 0x0040
  KEYMOD_RCTRL    = 0x0080
  KEYMOD_CTRL     = (0x0040 | 0x0080).freeze
  KEYMOD_LALT     = 0x0100
  KEYMOD_RALT     = 0x0200
  KEYMOD_ALT      = (0x0100 | 0x0200).freeze
  KEYMOD_LGUI     = 0x0400
  KEYMOD_RGUI     = 0x0800
  KEYMOD_GUI      = (0x0400 | 0x0800).freeze
  KEYMOD_NUM      = 0x1000
  KEYMOD_CAPS     = 0x2000
  KEYMOD_MODE     = 0x4000
  KEYMOD_SCROLL   = 0x8000
  KEYMOD_RESERVED = 0x8000
end

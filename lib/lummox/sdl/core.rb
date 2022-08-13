# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core
  extend FFI::Library
  extend CoreHelpers

  LIB_SDL2 = ENV.fetch("LIB_SDL2").freeze
  ffi_lib_flags :now, :global
  ffi_lib [FFI::CURRENT_PROCESS, LIB_SDL2]

  enum :bool, %i[false true]

  # TRICKY: Not true SDL enums - invented for cleanliness
  ToggleState = Lummox::SDL::Core.enum(:query, -1, :disable, :enable).freeze
  ButtonState = Lummox::SDL::Core.enum(:released, :pressed).freeze

  typedef :uint32,  :audio_device_id
  typedef :pointer, :cursor_pointer
  typedef :pointer, :game_controller_pointer
  typedef :int32,   :joystick_id
  typedef :pointer, :joystick_pointer
  typedef :uint32,  :window_id
  typedef :pointer, :window_pointer

  # TRICKY: Creates pointer helpers for each class, e.g. :uint8 creates Uint8Ptr and :uint8_pointer typedef
  %i[uint8 uint32 int float].each do |type|
    klass = const_set(:"#{camel_case(type)}Ptr", pointer_struct(type))
    typedef klass.by_ref, :"#{type}_pointer"
  end

  # TODO:
  # include Render
  # include Audio
  # include Hints
  # include Clipboard
  # include Haptic
  include Error
  include Events
  include GameController
  include Initialization
  include Joystick
  include Keyboard
  include MessageBox
  include Mouse
  include Pixel
  include Rect
  include Timer
  include Video
end

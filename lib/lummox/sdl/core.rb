# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core
  LIB_SDL2 = ENV.fetch("LIB_SDL2").freeze
  extend FFI::Library
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

  typedef Lummox::SDL::Core::Helpers::IntPtr.by_ref, :int_pointer
  typedef Lummox::SDL::Core::Helpers::FloatPtr.by_ref, :float_pointer

  def self.attach_sdl_function(method_name, args, ret, **opts)
    sdl_method_name = opts.delete(:sdl_method_name) || sdl_method_name(method_name)
    attach_function method_name, sdl_method_name, args, ret, **opts
    private method_name
  end

  def self.sdl_method_name(method_name)
    base_name = /(sdl_)?(\w*)/.match(method_name).captures[1]
    :"SDL_#{camel_case(base_name)}"
  end

  def self.camel_case(sym)
    str = sym.to_s
    return sym if str !~ /_/ && str =~ /[A-Z]+.*/

    str.split("_").map(&:capitalize).join.to_sym
  end

  include Helpers

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

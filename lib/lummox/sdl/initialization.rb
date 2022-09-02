# frozen_string_literal: true

module Lummox::SDL::Initialization
  INIT_TIMER           = 0x00000001
  INIT_AUDIO           = 0x00000010
  INIT_VIDEO           = 0x00000020
  INIT_JOYSTICK        = 0x00000200
  INIT_HAPTIC          = 0x00001000
  INIT_GAME_CONTROLLER = 0x00002000
  INIT_EVENTS          = 0x00004000
  INIT_SENSOR          = 0x00008000

  def self.included(base)
    base.class_eval do
      attach_sdl_function :init, [:uint32], :int # negative if error
      attach_sdl_function :was_init, [:uint32], :uint32
      attach_sdl_function :quit, [], :void
    end
  end
end

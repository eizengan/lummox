# frozen_string_literal: true

# TODO: move into Core directly?
module Lummox::SDL::Core::Initialization
  extend Lummox::SDL::Core::Library

  SDL_INIT_TIMER          = 0x00000001
  SDL_INIT_AUDIO          = 0x00000010
  SDL_INIT_VIDEO          = 0x00000020
  SDL_INIT_JOYSTICK       = 0x00000200
  SDL_INIT_HAPTIC         = 0x00001000
  SDL_INIT_GAMECONTROLLER = 0x00002000
  SDL_INIT_EVENTS         = 0x00004000
  SDL_INIT_SENSOR         = 0x00008000

  attach_sdl_function :init, [:uint32], :int # negative if error
  attach_sdl_function :was_init, [:uint32], :uint32
  attach_sdl_function :quit, [], :void
end

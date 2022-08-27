# frozen_string_literal: true

# TODO:
# NEXT UP:
# custom RWOps
# - SDL_AllocRW
# - SDL_FreeRW
# specialty readers
# - SDL_ReadBE16
# - SDL_ReadBE32
# - SDL_ReadBE64
# - SDL_ReadLE16
# - SDL_ReadLE32
# - SDL_ReadLE64
# - SDL_ReadU8
# specialty writers
# - SDL_WriteBE16
# - SDL_WriteBE32
# - SDL_WriteBE64
# - SDL_WriteLE16
# - SDL_WriteLE32
# - SDL_WriteLE64
# - SDL_WriteU8
# IGNORE:
# - SDL_RWFromFP - file from standard I/O file pointer
module Lummox::SDL::Core::IO
  def self.included(base)
    base.class_eval do
      # Creation, identification, ownership
      attach_sdl_function :rw_from_file, %i[string string], RWOps.by_ref, sdl_method_name: :SDL_RWFromFile
      attach_sdl_function :rw_from_mem, %i[pointer int], RWOps, sdl_method_name: :SDL_RWFromMem
      attach_sdl_function :rw_from_const_mem, %i[pointer int], RWOps, sdl_method_name: :SDL_RWFromConstMem
      attach_sdl_function :rw_close, [RWOps.by_ref], :int, sdl_method_name: :SDL_RWclose # negative if error
      # Standard ops
      attach_sdl_function :rw_read, [RWOps.by_ref, :pointer, :size_t, :size_t], :size_t, sdl_method_name: :SDL_RWread
      attach_sdl_function :rw_seek, [RWOps.by_ref, :int64, RWSeekPosition], :int64, sdl_method_name: :SDL_RWseek
      attach_sdl_function :rw_size, [RWOps.by_ref], :int64, sdl_method_name: :SDL_RWsize
      attach_sdl_function :rw_tell, [RWOps.by_ref], :int64, sdl_method_name: :SDL_RWtell
      attach_sdl_function :rw_write, [RWOps.by_ref, :pointer, :size_t, :size_t], :size_t, sdl_method_name: :SDL_RWwrite
    end
  end
end

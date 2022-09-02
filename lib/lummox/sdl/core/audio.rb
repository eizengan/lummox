# frozen_string_literal: true

# TODO:
# SDL_AudioFormat
# SDL_MixAudioFormat
# SDL_AudioCVT
# SDL_BuildAudioCVT
# SDL_ConvertAudio
# SDL_AudioStream
# SDL_LockAudioDevice
# SDL_UnlockAudioDevice
# NEXT UP:
# SDL_AudioInit - actually useful for driver-based init; how to do this?
# SDL_AudioQuit - actually useful for driver-based init; how to do this?
# IGNORE:
# SDL_CloseAudio     - legacy interface
# SDL_GetAudioStatus - legacy interface
# SDL_LockAudio      - legacy interface
# SDL_MixAudio       - legacy interface
# SDL_OpenAudio      - legacy interface
# SDL_PauseAudio     - legacy interface
# SDL_UnlockAudio    - legacy interface
module Lummox::SDL::Core::Audio
  # rubocop:disable Layout/LineLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength

  AUDIO_S8     = 0x8008
  AUDIO_U8     = 0x0008
  AUDIO_S16LSB = 0x8010
  AUDIO_S16MSB = 0x9010
  # AUDIO_S16SYS = ??? - TODO: system endianness determination?
  AUDIO_S16    = AUDIO_S16LSB
  AUDIO_U16LSB = 0x0010
  AUDIO_U16MSB = 0x1010
  # AUDIO_U16SYS = ??? - TODO: system endianness determination?
  AUDIO_U16    = AUDIO_U16LSB
  AUDIO_S32LSB = 0x8020
  AUDIO_S32MSB = 0x9020
  # AUDIO_S32SYS = ??? - TODO: system endianness determination?
  AUDIO_S32    = AUDIO_S32LSB
  AUDIO_F32LSB = 0x8120
  AUDIO_F32MSB = 0x9120
  # AUDIO_F32SYS = ??? - TODO: system endianness determination?
  AUDIO_F32    = AUDIO_F32LSB

  AUDIO_ALLOW_FREQUENCY_CHANGE = 0x00000001
  AUDIO_ALLOW_FORMAT_CHANGE    = 0x00000002
  AUDIO_ALLOW_CHANNELS_CHANGE  = 0x00000004
  AUDIO_ALLOW_SAMPLES_CHANGE   = 0x00000008
  AUDIO_ALLOW_ANY_CHANGE       = (AUDIO_ALLOW_FREQUENCY_CHANGE | AUDIO_ALLOW_FORMAT_CHANGE | AUDIO_ALLOW_CHANNELS_CHANGE | AUDIO_ALLOW_SAMPLES_CHANGE).freeze

  def self.included(base)
    base.class_eval do
      # Drivers
      attach_sdl_function :get_num_audio_drivers, [], :int
      attach_sdl_function :get_audio_driver, [:int], :string
      attach_sdl_function :get_current_audio_driver, [], :string
      # Devices
      #   Creation, identification, ownership
      attach_sdl_function :get_num_audio_devices, [:int], :int
      attach_sdl_function :get_audio_device_name, %i[int int], :string # null if error
      attach_sdl_function :open_audio_device, [:string, :int, AudioSpec.by_ref, AudioSpec.by_ref, :int], :audio_device_id # 0 if error
      attach_sdl_function :close_audio_device, [:audio_device_id], :void
      #   Status
      attach_sdl_function :get_audio_device_status, [:audio_device_id], AudioStatus
      attach_sdl_function :pause_audio_device, %i[audio_device_id bool], :void
      #   Queueing
      attach_sdl_function :get_queued_audio_size, [:audio_device_id], :uint32
      attach_sdl_function :queue_audio, %i[audio_device_id pointer uint32], :int # negative if error
      attach_sdl_function :dequeue_audio, %i[audio_device_id pointer uint32], :uint32 # negative may have info if return < request
      attach_sdl_function :clear_queued_audio, [:audio_device_id], :void
      # WAV files
      attach_sdl_function :free_wav, [:pointer], :void, sdl_method_name: :SDL_FreeWAV
      attach_sdl_function :load_wav_rw, [Lummox::SDL::Core::IO::RWOps.by_ref, :bool, AudioSpec.by_ref, :pointer, :uint32_pointer], :void, sdl_method_name: :SDL_LoadWAV_RW # null if error
    end
  end

  # rubocop:enable all
end

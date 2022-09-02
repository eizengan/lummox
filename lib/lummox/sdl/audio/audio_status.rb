# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Audio
  AudioStatus = Lummox::SDL.enum(
    FFI::Type::INT,
    :audio_stopped,
    :audio_playing,
    :audio_paused
  ).freeze
end

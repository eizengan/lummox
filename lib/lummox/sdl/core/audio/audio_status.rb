# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Audio
  AudioStatus = Lummox::SDL::Core.enum(
    FFI::Type::INT,
    :audio_stopped,
    :audio_playing,
    :audio_paused
  ).freeze
end

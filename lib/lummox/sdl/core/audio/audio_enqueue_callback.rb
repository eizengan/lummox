# frozen_string_literal: true

module Lummox::SDL::Core::Audio
  AudioEnqueueCallback = Lummox::SDL::Core.callback(:audio_enqueue_function, [:pointer, :pointer, :int], :void).freeze
end

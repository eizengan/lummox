# frozen_string_literal: true

module Lummox::SDL::Audio
  AudioEnqueueCallback = Lummox::SDL.callback(:audio_enqueue_function, %i[pointer pointer int], :void).freeze
end

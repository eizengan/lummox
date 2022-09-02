# frozen_string_literal: true

module Lummox::SDL::Core::Audio
  AudioEnqueueCallback = Lummox::SDL::Core.callback(:audio_enqueue_function, %i[pointer pointer int], :void).freeze
end

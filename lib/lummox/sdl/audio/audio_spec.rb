# frozen_string_literal: true

class Lummox::SDL::Audio::AudioSpec < Lummox::SDL::Struct
  # TODO: better handling of format flags
  layout :freq,     :int,
         :format,   :uint16,
         :channels, :uint8,
         :silence,  :uint8,
         :samples,  :uint16,
         :padding,  :uint16,
         :size,     :uint32,
         :callback, Lummox::SDL::Audio::AudioEnqueueCallback,
         :user_data, :pointer
end

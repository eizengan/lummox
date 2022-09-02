# frozen_string_literal: true

module Lummox::SDL::Error
  def self.included(base)
    base.class_eval do
      attach_sdl_function :set_error, [:string], :int # always returns -1 error code
      attach_sdl_function :clear_error, [], :void
      attach_sdl_function :get_error, [], :string
    end
  end
end

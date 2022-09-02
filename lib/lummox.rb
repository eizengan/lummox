# frozen_string_literal: true

require_relative "lummox/zeitwerk"

module Lummox
  def configuration
    yield Configuration.instance if block_given?

    Configuration.instance
  end

  def self.init!
    SDLError.raise_if(:negative?) { SDL.init(Configuration.sdl_init_flags) }
  end

  def self.quit!
    SDL.quit
  end
end

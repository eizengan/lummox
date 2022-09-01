# frozen_string_literal: true

require_relative "lummox/zeitwerk"

module Lummox
  def self.init!
    SDL.init!
  end

  def self.quit!
    SDL.quit!
  end
end

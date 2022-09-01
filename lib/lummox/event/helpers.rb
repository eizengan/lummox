# frozen_string_literal: true

require "forwardable"

module Lummox::Event::Helpers
  include Forwardable

  def self.extended(base)
    base.attr_reader :sdl_event
    base.delegate_to_event :type
    base.delegate_to_event :timestamp
  end

  def delegate_to_event(field, alias_as: nil)
    def_delegator(*[:@sdl_event, field, alias_as].compact)
  end
end

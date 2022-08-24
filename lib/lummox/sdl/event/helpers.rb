# frozen_string_literal: true

require "forwardable"

module Lummox::SDL::Event::Helpers
  include Forwardable

  def self.extended(base)
    base.attr_reader :event
    base.delegate_to_event :type
    base.delegate_to_event :timestamp
  end

  def delegate_to_event(field, alias_as: nil)
    def_delegator(*[:@event, field, alias_as].compact)
  end
end

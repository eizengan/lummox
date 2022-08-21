# frozen_string_literal: true

module Lummox::SDL::Event::Helpers
  def self.included(base)
    base.attr_reader :event
    base.extend ClassMethods
    base.delegate_to_event :type
    base.delegate_to_event :timestamp
  end

  module ClassMethods
    def delegate_to_event(field, alias_as: nil)
      method_name = alias_as || field
      define_method(method_name) { @event[field] }
    end
  end
end

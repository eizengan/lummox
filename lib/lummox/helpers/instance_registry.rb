# frozen_string_literal: true

module Lummox::Helpers::InstanceRegistry
  def self.included(base)
    base.instance_variable_set(:@registry, {})
    base.attr_reader :registry
    base.extend ClassMethods
  end

  module ClassMethods
    def all_instances
      @registry.values
    end

    def register_instance(id, instance)
      @registry[id] = instance
    end

    def deregister_instance(id)
      @registry.delete(id)
    end

    def find_instance(id)
      @registry[id]
    end
  end
end

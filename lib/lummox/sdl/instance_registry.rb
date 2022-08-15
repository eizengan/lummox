# frozen_string_literal: true

module Lummox::SDL::InstanceRegistry
  def self.included(base)
    base.instance_variable_set(:@registry, {})
    base.attr_reader :registry
    base.extend ClassMethods
  end

  module ClassMethods
    def all_instances
      @registry.values
    end

    def register_instance(pointer, instance)
      @registry[pointer.address] = instance
    end

    def deregister_instance(pointer)
      @registry.delete(pointer.address)
    end

    def find_instance(pointer)
      @registry[pointer.address]
    end
  end
end

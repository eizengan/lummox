# frozen_string_literal: true

class Lummox::Helpers::FlagSet
  @prefixed_flag_map = {}
  @prefix = ""

  class << self
    attr_reader :prefixed_flag_map, :prefix

    def for(prefixed_flag_map, prefix: "")
      Class.new(self) do
        @prefixed_flag_map = prefixed_flag_map
        @prefix = prefix
      end
    end

    def value_of(flag)
      prefixed_flag = :"#{prefix}#{flag.upcase}"
      prefixed_flag_map[prefixed_flag]
    end

    def remove_prefix(prefixed_flag)
      prefixed_flag[prefix.size..].downcase.to_sym
    end

    def flags
      @flags ||= prefixed_flag_map.keys.map { |prefixed_flag| remove_prefix(prefixed_flag) }
    end
  end

  attr_reader :value

  def initialize(*flags, value: 0, all: false)
    @value = value
    flags = self.class.flags if all
    flags.each { |flag| add(flag) }
  end

  def add(flag)
    @value |= self.class.value_of(flag) unless include?(flag)
    self
  end

  def remove(flag)
    @value ^= self.class.value_of(flag) if include?(flag)
    self
  end

  def include?(flag)
    flag_value = self.class.value_of(flag)
    value_include?(flag_value)
  end

  def to_a
    self.class.prefixed_flag_map
        .select { |_k, v| value_include?(v) }
        .keys
        .map { |prefixed_flag| self.class.remove_prefix(prefixed_flag) }
  end

  private

  def value_include?(flag_value)
    (value & flag_value) == flag_value
  end
end

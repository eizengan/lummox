# frozen_string_literal: true

class Lummox::Helpers::FlagSet
  @flag_map = {}
  @prefix = ""

  class << self
    attr_reader :flag_map, :prefix

    def for(flag_map, prefix: "")
      Class.new(self) do
        @flag_map = flag_map
        @prefix = prefix
      end
    end

    def value_of(flag)
      prefixed_flag = :"#{prefix}#{flag.upcase}"
      flag_map[prefixed_flag]
    end
  end

  attr_reader :value

  def initialize(*flags, value: 0)
    @value = value
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
    prefix_size = self.class.prefix.size
    self.class.flag_map
        .select { |_k, v| value_include?(v) }
        .keys
        .map { |flag| flag[prefix_size..].downcase.to_sym }
  end

  private

  def value_include?(flag_value)
    (value & flag_value) == flag_value
  end
end

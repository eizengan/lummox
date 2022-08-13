# frozen_string_literal: true

class Lummox::SDL::Core::Struct < FFI::Struct
  def self.layout(*spec)
    super

    members.each do |member|
      define_method(:"#{member}") { self[member] }
      define_method(:"#{member}=") { |value| self[member] = value }
    end
  end

  def initialize(*args, **init_vals)
    super(*args)

    init_vals.each { |member, value| self[member] = value }
  end
end

# frozen_string_literal: true

module Lummox::SDL::Pointers
  class Int < FFI::Struct
    layout  :value, :int

    def value
      self[:value]
    end
  end

  class Float < FFI::Struct
    layout  :value, :float

    def value
      self[:value]
    end
  end
end

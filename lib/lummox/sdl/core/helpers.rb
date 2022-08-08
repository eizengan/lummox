# frozen_string_literal: true

module Lummox::SDL::Core::Helpers
  class IntPtr < FFI::Struct
    layout  :value, :int

    def value
      self[:value]
    end
  end

  class FloatPtr < FFI::Struct
    layout  :value, :float

    def value
      self[:value]
    end
  end
end

# frozen_string_literal: true

module Lummox::SDL::Core::Events
  # TRICKY: Not an SDL enum - invented for simplicity
  ButtonState = Lummox::SDL::Core.enum(:released, :pressed)
end

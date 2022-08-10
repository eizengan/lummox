# frozen_string_literal: true

module Lummox::SDL::Core::Events
  # TRICKY: Not an SDL enum - invented for simplicity
  EventState = Lummox::SDL::Core.enum(:query, -1, :disable, :enable)
end

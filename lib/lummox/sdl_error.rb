# frozen_string_literal: true

class Lummox::SDLError < StandardError
  class << self
    def raise_if(method_sym)
      result = yield
      raise_current_error if result.send(method_sym)
      result
    end

    def raise_unless(method_sym)
      result = yield
      raise_current_error unless result.send(method_sym)
      result
    end

    def raise_current_error
      error_message = Lummox::SDL.get_error
      raise self, error_message
    end
  end
end

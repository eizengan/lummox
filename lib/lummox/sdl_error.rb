# frozen_string_literal: true

class Lummox::SDLError < StandardError
  class << self
    def raise_if
      raise_current_error if yield
    end

    def raise_unless
      raise_current_error unless yield
    end

    def raise_current_error
      error_message, _pointer = Lummox::SDL::Error.get_error
      raise self, error_message
    end
  end
end

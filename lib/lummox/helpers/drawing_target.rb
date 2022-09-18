# frozen_string_literal: true

module Lummox::Helpers::DrawingTarget
  def clear(color = [0, 0, 0, 255])
    renderer.with_color(color) do
      Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.render_clear(renderer.pointer) }
    end
  end
end

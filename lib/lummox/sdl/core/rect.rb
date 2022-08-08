# frozen_string_literal: true

# NEXT UP:
# - SDL_EnclosePoints
# - SDL_HasIntersection
# - SDL_IntersectRect
# - SDL_IntersectRectAndLine
# - SDL_Point
# - SDL_PointInRect
# - SDL_Rect
# - SDL_RectEmpty
# - SDL_RectEquals
# - SDL_UnionRect

module Lummox::SDL::Core::Rect
  extend Lummox::SDL::Library

  class Rect < FFI::Struct
    layout *%i[
      x      int
      y      int
      width  int
      height int
    ]
  end
end

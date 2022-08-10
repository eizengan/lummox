# frozen_string_literal: true

# IGNORE
# - SDL_PointInRect - inlined function
# - SDL_RectEmpty - inlined function
# - SDL_RectEquals - inlined function
module Lummox::SDL::Core::Rect
  # rubocop:disable Layout/LineLength

  def self.included(base)
    base.class_eval do
      attach_sdl_function :enclose_points, [:pointer, :int, Rect.by_ref, Rect.by_ref], :bool
      attach_sdl_function :has_intersection, [Rect.by_ref, Rect.by_ref], :bool
      attach_sdl_function :intersect_rect, [Rect.by_ref, Rect.by_ref, Rect.by_ref], :bool
      attach_sdl_function :intersect_rect_and_line, [Rect.by_ref, :int_pointer, :int_pointer, :int_pointer, :int_pointer], :bool
      attach_sdl_function :union_rect, [Rect.by_ref, Rect.by_ref, Rect.by_ref], :void
    end
  end

  # rubocop:enable Layout/LineLength
end

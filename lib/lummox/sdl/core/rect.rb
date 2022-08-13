# frozen_string_literal: true

# IGNORE
# - SDL_PointInRect - inlined function
# - SDL_RectEmpty - inlined function
# - SDL_RectEquals - inlined function
module Lummox::SDL::Core::Rect
  # rubocop:disable Layout/LineLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength

  def self.included(base)
    base.class_eval do
      # Rect
      attach_sdl_function :enclose_points, [:pointer, :int, Rect.by_ref, Rect.by_ref], :bool
      attach_sdl_function :has_intersection, [Rect.by_ref, Rect.by_ref], :bool
      attach_sdl_function :intersect_rect, [Rect.by_ref, Rect.by_ref, Rect.by_ref], :bool
      attach_sdl_function :intersect_rect_and_line, [Rect.by_ref, :int_pointer, :int_pointer, :int_pointer, :int_pointer], :bool
      attach_sdl_function :union_rect, [Rect.by_ref, Rect.by_ref, Rect.by_ref], :void
      # FRect
      attach_sdl_function :enclose_f_points, [:pointer, :int, FRect.by_ref, FRect.by_ref], :bool
      attach_sdl_function :has_intersection_f, [FRect.by_ref, FRect.by_ref], :bool
      attach_sdl_function :intersect_f_rect, [FRect.by_ref, FRect.by_ref, FRect.by_ref], :bool
      attach_sdl_function :intersect_f_rect_and_line, [FRect.by_ref, :float_pointer, :float_pointer, :float_pointer, :float_pointer], :bool
      attach_sdl_function :union_f_rect, [FRect.by_ref, FRect.by_ref, FRect.by_ref], :void
    end
  end

  # rubocop:enable Layout/LineLength
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end

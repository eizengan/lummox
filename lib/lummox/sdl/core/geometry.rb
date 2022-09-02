# frozen_string_literal: true

# TRICKY: This file corresponds to the SDL_rect.h header. We rename here to avoid collision between the module's name
# and the Rect struct it adds to Lummox::SDL::Core when it is included
#
# IGNORE
# - SDL_PointInRect - inlined function
# - SDL_RectEmpty - inlined function
# - SDL_RectEquals - inlined function
module Lummox::SDL::Core::Geometry
  # rubocop:disable Layout/LineLength, Metrics/AbcSize, Metrics/MethodLength

  def self.included(base)
    base.class_eval do
      # Rect
      attach_sdl_function :enclose_points, [:buffer_in, :int, Rect.by_ref, Rect.by_ref], :bool
      attach_sdl_function :has_intersection, [Rect.by_ref, Rect.by_ref], :bool
      attach_sdl_function :intersect_rect, [Rect.by_ref, Rect.by_ref, Rect.by_ref], :bool
      attach_sdl_function :intersect_rect_and_line, [Rect.by_ref, :int_pointer, :int_pointer, :int_pointer, :int_pointer], :bool
      attach_sdl_function :union_rect, [Rect.by_ref, Rect.by_ref, Rect.by_ref], :void
      # FRect
      attach_sdl_function :enclose_f_points, [:buffer_in, :int, FRect.by_ref, FRect.by_ref], :bool
      attach_sdl_function :has_intersection_f, [FRect.by_ref, FRect.by_ref], :bool
      attach_sdl_function :intersect_f_rect, [FRect.by_ref, FRect.by_ref, FRect.by_ref], :bool
      attach_sdl_function :intersect_f_rect_and_line, [FRect.by_ref, :float_pointer, :float_pointer, :float_pointer, :float_pointer], :bool
      attach_sdl_function :union_f_rect, [FRect.by_ref, FRect.by_ref, FRect.by_ref], :void
    end
  end

  # rubocop:enable all
end

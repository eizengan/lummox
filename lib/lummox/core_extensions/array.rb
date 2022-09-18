# frozen_string_literal: true

Array.class_eval do
  extend Lummox::Helpers::Drawable
  self.default_drawing_type = nil
  register_drawing_method :points, :render_draw_points, &:points_drawing_args
  register_drawing_method :points_float, :render_draw_points_f, &:fpoints_drawing_args
  register_drawing_method :lines, :render_draw_lines, &:points_drawing_args
  register_drawing_method :lines_float, :render_draw_lines_f, &:fpoints_drawing_args
  register_drawing_method :rects, :render_draw_rects, &:rect_drawing_args
  register_drawing_method :rects_float, :render_draw_rects_f, &:frect_drawing_args
  register_drawing_method :fill_rects, :render_fill_rects, &:rect_drawing_args
  register_drawing_method :fill_rects_float, :render_fill_rects_f, &:frect_drawing_args

  def points_drawing_args
    drawing_args(Lummox::SDL::Point, :sdl_point)
  end

  def fpoints_drawing_args
    drawing_args(Lummox::SDL::FPoint, :sdl_fpoint)
  end

  def rect_drawing_args
    drawing_args(Lummox::SDL::Rect, :sdl_rect)
  end

  def frect_drawing_args
    drawing_args(Lummox::SDL::FRect, :sdl_frect)
  end

  private

  def drawing_args(sdl_class, convert_method)
    buffer = FFI::MemoryPointer.new(sdl_class, size)
    each_with_index { |p, index| p.send(convert_method, buffer + index * sdl_class.size) }
    [buffer, size]
  end
end

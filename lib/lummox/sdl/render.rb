# frozen_string_literal: true

# TODO:
# - SDL_RenderGeometry
# - SDL_RenderGeometryRaw
# - SDL_GL_BindTexture
# - SDL_GL_UnbindTexture
# - SDL_UpdateYUVTexture
# - SDL_RenderReadPixels
# IGNORE:
# - SDL_CreateWindowAndRenderer  - separate concerns
# - SDL_CreateSoftwareRenderer   - blitting, not rendering
# - SDL_CreateTextureFromSurface - blitting, not rendering
# - SDL_TextureModulate - internal use
module Lummox::SDL::Render
  RENDERER_FLAGS = {
    RENDERER_SOFTWARE: 0x00000001,
    RENDERER_ACCELERATED: 0x00000002,
    RENDERER_PRESENT_VSYNC: 0x00000004,
    RENDERER_TARGET_TEXTURE: 0x00000008
  }.freeze

  RENDERER_FLIP = {
    FLIP_NONE: 0x00000000,
    FLIP_HORIZONTAL: 0x00000001,
    FLIP_VERTICAL: 0x00000002
  }.freeze

  # rubocop:disable Layout/LineLength, Metrics/AbcSize, Metrics/BlockLength, Metrics/MethodLength

  def self.included(base)
    base.class_eval do
      # Renderer
      #   Creation
      attach_sdl_function :create_renderer, %i[window_pointer int uint32], :renderer_pointer # nil if error, free with destroy_renderer
      attach_sdl_function :destroy_renderer, [:renderer_pointer], :void
      attach_sdl_function :get_renderer, [:window_pointer], :renderer_pointer # nil if error
      #   Information
      attach_sdl_function :get_num_render_drivers, [], :int # negative if error
      attach_sdl_function :get_render_driver_info, [:int, RendererInfo.by_ref], :int # negative if error
      attach_sdl_function :get_renderer_info, [:renderer_pointer, RendererInfo.by_ref], :int # negative if error
      attach_sdl_function :get_renderer_output_size, [:renderer_pointer, :int_pointer, :int_pointer], :int # negative if error
      #   Targeting
      attach_sdl_function :render_target_supported, [:renderer_pointer], :bool
      attach_sdl_function :get_render_target, [:renderer_pointer], :texture_pointer
      attach_sdl_function :set_render_target, %i[renderer_pointer texture_pointer], :int # negative if error
      #   Drawing area
      attach_sdl_function :render_get_viewport, [:renderer_pointer, Lummox::SDL::Geometry::Rect.by_ref], :void
      attach_sdl_function :render_set_viewport, [:renderer_pointer, Lummox::SDL::Geometry::Rect.by_ref], :int # negative if error
      attach_sdl_function :render_get_integer_scale, [:renderer_pointer], :bool # false may have error
      attach_sdl_function :render_set_integer_scale, %i[renderer_pointer bool], :int # negative if error
      attach_sdl_function :render_get_logical_size, %i[renderer_pointer int_pointer int_pointer], :void
      attach_sdl_function :render_set_logical_size, %i[renderer_pointer int int], :int # negative if error
      attach_sdl_function :render_get_scale, %i[renderer_pointer float_pointer float_pointer], :void
      attach_sdl_function :render_set_scale, %i[renderer_pointer float float], :int # negative if error
      attach_sdl_function :render_is_clip_enabled, [:renderer_pointer], :bool
      attach_sdl_function :render_get_clip_rect, [:renderer_pointer, Lummox::SDL::Geometry::Rect.by_ref], :void
      attach_sdl_function :render_set_clip_rect, [:renderer_pointer, Lummox::SDL::Geometry::Rect.by_ref], :void # negative if error
      # Texture
      #   Creation
      attach_sdl_function :create_texture, [:renderer_pointer, :uint32, TextureAccess, :int, :int], :texture_pointer # nil if error, free with destroy_texture
      attach_sdl_function :destroy_texture, [:texture_pointer], :void
      #   Information
      attach_sdl_function :query_texture, %i[texture_pointer uint32_pointer int_pointer int_pointer int_pointer], :int # negative if error
      #   Properties
      attach_sdl_function :get_texture_blend_mode, %i[texture_pointer uint32_pointer], :int # negative if error
      attach_sdl_function :set_texture_blend_mode, %i[texture_pointer uint32], :int # negative if error
      attach_sdl_function :get_texture_alpha_mod, %i[texture_pointer uint8_pointer], :int # negative if error
      attach_sdl_function :set_texture_alpha_mod, %i[texture_pointer uint8], :int # negative if error
      attach_sdl_function :get_texture_color_mod, %i[texture_pointer uint8_pointer uint8_pointer uint8_pointer], :int # negative if error
      attach_sdl_function :set_texture_color_mod, %i[texture_pointer uint8 uint8 uint8], :int # negative if error
      #   Modification
      attach_sdl_function :lock_texture, [:texture_pointer, Lummox::SDL::Geometry::Rect.by_ref, :buffer_inout, :int], :int # negative if error
      attach_sdl_function :unlock_texture, [:texture_pointer], :void
      attach_sdl_function :update_texture, [:texture_pointer, Lummox::SDL::Geometry::Rect.by_ref, :buffer_in, :int], :int # negative if error
      # Drawing
      attach_sdl_function :render_clear, [:renderer_pointer], :int # negative if error
      attach_sdl_function :render_present, [:renderer_pointer], :void
      #   Properties
      attach_sdl_function :get_render_draw_blend_mode, %i[renderer_pointer uint32_pointer], :int # negative if error
      attach_sdl_function :set_render_draw_blend_mode, %i[renderer_pointer uint32], :int # negative if error
      attach_sdl_function :get_render_draw_color, %i[renderer_pointer uint8_pointer uint8_pointer uint8_pointer uint8_pointer], :int # negative if error
      attach_sdl_function :set_render_draw_color, %i[renderer_pointer uint8 uint8 uint8 uint8], :int # negative if error
      #   Lines
      attach_sdl_function :render_draw_line, %i[renderer_pointer int int int int], :int # negative if error
      attach_sdl_function :render_draw_line_f, %i[renderer_pointer float float float float], :int # negative if error
      attach_sdl_function :render_draw_lines, %i[renderer_pointer buffer_in int], :int # negative if error
      attach_sdl_function :render_draw_lines_f, %i[renderer_pointer buffer_in int], :int # negative if error
      #   Points
      attach_sdl_function :render_draw_point, %i[renderer_pointer int int], :int # negative if error
      attach_sdl_function :render_draw_point_f, %i[renderer_pointer float float], :int # negative if error
      attach_sdl_function :render_draw_points, %i[renderer_pointer buffer_in int], :int # negative if error
      attach_sdl_function :render_draw_points_f, %i[renderer_pointer buffer_in int], :int # negative if error
      #   Rects
      attach_sdl_function :render_draw_rect, [:renderer_pointer, Lummox::SDL::Geometry::Rect.by_ref], :int # negative if error
      attach_sdl_function :render_draw_rect_f, [:renderer_pointer, Lummox::SDL::Geometry::FRect.by_ref], :int # negative if error
      attach_sdl_function :render_draw_rects, %i[renderer_pointer buffer_in int], :int # negative if error
      attach_sdl_function :render_draw_rects_f, %i[renderer_pointer buffer_in int], :int # negative if error
      #   FillRects
      attach_sdl_function :render_fill_rect, [:renderer_pointer, Lummox::SDL::Geometry::Rect.by_ref], :int # negative if error
      attach_sdl_function :render_fill_rect_f, [:renderer_pointer, Lummox::SDL::Geometry::FRect.by_ref], :int # negative if error
      attach_sdl_function :render_fill_rects, %i[renderer_pointer buffer_in int], :int # negative if error
      attach_sdl_function :render_fill_rects_f, %i[renderer_pointer buffer_in int], :int # negative if error
      #   Textures
      attach_sdl_function :render_copy, [:renderer_pointer, :texture_pointer, Lummox::SDL::Geometry::Rect.by_ref, Lummox::SDL::Geometry::Rect.by_ref], :int # negative if error
      attach_sdl_function :render_copy_f, [:renderer_pointer, :texture_pointer, Lummox::SDL::Geometry::Rect.by_ref, Lummox::SDL::Geometry::FRect.by_ref], :int # negative if error
      attach_sdl_function :render_copy_ex, [:renderer_pointer, :texture_pointer, Lummox::SDL::Geometry::Rect.by_ref, Lummox::SDL::Geometry::Rect.by_ref, :double, Lummox::SDL::Geometry::Point.by_ref, :uint32], :int # negative if error
      attach_sdl_function :render_copy_ex_f, [:renderer_pointer, :texture_pointer, Lummox::SDL::Geometry::Rect.by_ref, Lummox::SDL::Geometry::FRect.by_ref, :double, Lummox::SDL::Geometry::FPoint.by_ref, :uint32], :int # negative if error
      # Blending
      attach_sdl_function :compose_custom_blend_mode, [BlendFactor, BlendFactor, BlendOperation, BlendFactor, BlendFactor, BlendOperation], :uint32
    end
  end

  # rubocop:enable all
end

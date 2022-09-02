# frozen_string_literal: true

class Lummox::SDL::Render::RendererInfo < Lummox::SDL::Struct
  layout :flags,               :uint32,
         :num_texture_formats, :uint32,
         :texture_formats,     [:uint32, 16],
         :max_texture_width,   :int,
         :max_texture_height,  :int
end

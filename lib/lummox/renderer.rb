# frozen_string_literal: true

class Lummox::Renderer
  RendererFlags = Lummox::Helpers::FlagSet.for(Lummox::SDL::RENDERER_FLAGS, prefix: :RENDERER_) # rubocop:disable Style/MutableConstant
end

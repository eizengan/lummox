# frozen_string_literal: true

# sdl method for drawing
module Lummox::Helpers::Drawable
  def self.extended(base)
    base.instance_variable_set(:@default_drawing_type, nil)
    base.instance_variable_set(:@drawing_type_methods, {})
    class << base
      attr_accessor :default_drawing_type
      attr_reader :drawing_type_methods
    end

    base.extend ClassMethods

    base.include InstanceMethods
    base.attr_writer :drawing_type
  end

  module InstanceMethods
    def drawing_type
      @drawing_type ||= self.class.default_drawing_type
    end

    def draw(renderer)
      sdl_method, drawing_args = self.class.drawing_type_methods[drawing_type]
      args = drawing_args.call(self)
      Lummox::SDLError.raise_if(:negative?) { Lummox::SDL.send(sdl_method, renderer.pointer, *args) }
    end
  end

  module ClassMethods
    def register_drawing_method(drawing_type, sdl_method, &drawing_args)
      drawing_type_methods[drawing_type] = [sdl_method, drawing_args]
    end
  end
end

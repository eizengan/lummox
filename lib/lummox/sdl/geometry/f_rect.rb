# frozen_string_literal: true

class Lummox::SDL::Geometry::FRect < Lummox::SDL::Struct
  layout :x, :float,
         :y, :float,
         :w, :float,
         :h, :float
end

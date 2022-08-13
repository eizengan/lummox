# frozen_string_literal: true

module Lummox::SDL::Core::CoreHelpers
  def attach_sdl_function(method_name, args, ret, **opts)
    sdl_method_name = opts.delete(:sdl_method_name) || sdl_method_name(method_name)
    attach_function method_name, sdl_method_name, args, ret, **opts
    private method_name
  end

  def sdl_method_name(method_name)
    base_name = /(sdl_)?(\w*)/.match(method_name).captures[1]
    :"SDL_#{camel_case(base_name)}"
  end

  def camel_case(sym)
    str = sym.to_s
    return sym if str !~ /_/ && str =~ /[A-Z]+.*/

    str.split("_").map(&:capitalize).join.to_sym
  end

  def pointer_struct(type)
    Class.new(FFI::Struct) do
      layout :value, type

      def value
        self[:value]
      end
    end
  end
end

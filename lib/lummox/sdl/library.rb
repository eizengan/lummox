# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Library
  LIB_SDL2 = ENV.fetch("LIB_SDL2").freeze

  def self.extended(mod)
    super
    mod.extend FFI::Library
    mod.ffi_lib_flags :now, :global
    mod.ffi_lib [FFI::CURRENT_PROCESS, LIB_SDL2]
  end

  def attach_sdl_function(method_name, args, ret, visibility: :public)
    sdl_method_name = sdl_method_name(method_name)
    attach_function method_name, sdl_method_name, args, ret

    private method_name unless %i[public instance].include?(visibility)
    private_class_method method_name unless %i[public module class].include?(visibility)
  end

  private

  def sdl_method_name(method_name)
    base_name = /(sdl_)?(\w*)/.match(method_name).captures[1]
    :"SDL_#{camel_case(base_name)}"
  end

  def camel_case(sym)
    str = sym.to_s
    return str if str !~ /_/ && str =~ /[A-Z]+.*/

    str.split("_").map(&:capitalize).join.to_sym
  end
end

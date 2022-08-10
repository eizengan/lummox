# frozen_string_literal: true

require "ffi"

module Lummox::SDL::Core::Library
  LIB_SDL2 = ENV.fetch("LIB_SDL2").freeze

  def self.included(base)
    super

    base.extend FFI::Library
    base.extend ClassMethods

    base.ffi_lib_flags :now, :global
    base.ffi_lib [FFI::CURRENT_PROCESS, LIB_SDL2]

    base.enum :bool, %i[false true]
    base.typedef Lummox::SDL::Core::Helpers::IntPtr.by_ref, :int_pointer
    base.typedef Lummox::SDL::Core::Helpers::FloatPtr.by_ref, :float_pointer
  end

  module ClassMethods
    def attach_sdl_function(method_name, args, ret, **opts)
      sdl_method_name = sdl_method_name(method_name)
      attach_function method_name, sdl_method_name, args, ret, **opts
      private method_name
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

  private_constant :ClassMethods
end

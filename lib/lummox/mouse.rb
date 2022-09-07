# frozen_string_literal: true

# TODO:
# - capture_mouse, [:bool], :int # negative if error
# - get_global_mouse_state, %i[int_pointer int_pointer], :uint32
# - get_mouse_focus, [], :window_pointer
# - get_mouse_state, %i[int_pointer int_pointer], :uint32
# - get_relative_mouse_mode, [], :bool
# - get_relative_mouse_state, %i[int_pointer int_pointer], :uint32
# - set_relative_mouse_mode, [:bool], :int # negative if error
# - warp_mouse_global, %i[int int], :void
# - warp_mouse_in_window, %i[int int], :int # negative if error
# IGNORE:
module Lummox::Mouse
end

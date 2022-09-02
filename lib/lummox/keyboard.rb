# frozen_string_literal: true

require "ffi"
require "forwardable"
require "singleton"

# TODO:
# - get_mod_state
# IGNORE:
# - set_text_input_rect - how does ime work?
# - set_mod_state       - this function is poor form
class Lummox::Keyboard
  include Singleton
  extend SingleForwardable

  def_delegators :instance, :pressed?

  class << self
    def keycode_for(scancode_or_name)
      if scancode_or_name.is_a? Symbol
        Lummox::SDL.get_key_from_scancode(scancode_or_name)
      else
        Lummox::SDL.get_key_from_name(scancode_or_name)
      end
    end

    def scancode_for(keycode_or_name)
      if keycode_or_name.is_a? Symbol
        Lummox::SDL.get_scancode_from_key(keycode_or_name)
      else
        Lummox::SDL.get_scancode_from_name(keycode_or_name)
      end
    end

    def name_for(scancode_or_keycode)
      if scancode_or_keycode.match?(/scancode_.*/)
        Lummox::SDL.get_scancode_name(scancode_or_keycode)
      else
        Lummox::SDL.get_key_name(scancode_or_keycode)
      end
    end

    def focused_window
      window_pointer = Lummox::SDL.get_keyboard_focus
      Lummox::Window.find_instance(window_pointer.address)
    end

    def screen_keyboard_available?
      Lummox::SDL.has_screen_keyboard_support == :true
    end

    def screen_keyboard_shown?(window)
      Lummox::SDL.is_screen_keyboard_shown(window.pointer) == :true
    end

    def text_input_enabled?
      Lummox::SDL.is_text_input_active == :true
    end

    def text_input_enabled=(enabled)
      if enabled
        Lummox::SDL.start_text_input
      else
        Lummox::SDL.stop_text_input
      end
    end
  end

  def initialize
    @keyboard_state = Lummox::SDL.get_keyboard_state(nil)
  end

  def pressed?(scancode_or_keycode)
    index = keyboard_state_index_for(scancode_or_keycode)
    return !@keyboard_state.get(:uint8, index).zero? unless index.nil?

    raise Lummox::SDLError, "Unknown keycode or scancode '#{scancode_or_keycode}'"
  end

  private

  def keyboard_state_index_for(scancode_or_keycode)
    scancode = if scancode_or_keycode.match?(/scancode_.*/)
                 scancode_or_keycode
               else
                 self.class.scancode_for(scancode_or_keycode)
               end

    Lummox::SDL::Scancode[scancode]
  end
end

# frozen_string_literal: true

require "ffi"

# TODO:
# - game_controller_get_joystick - implement alongside Joystick
# IGNORE:
# - game_controller_name_for_index - connect to get name
# - game_controller_get_axis_from_string - direct access should be fine
# - game_controller_get_bind_for_axis - direct access should be fine
# - game_controller_get_string_for_axis - direct access should be fine
# - game_controller_get_button_from_string - direct access should be fine
# - game_controller_get_bind_for_button - direct access should be fine
# - game_controller_get_string_for_button - direct access should be fine

class Lummox::Controller
  AXES = Set.new(Lummox::SDL::Core::GameControllerAxis.symbols).freeze
  BUTTONS = Set.new(Lummox::SDL::Core::GameControllerButton.symbols).freeze

  include Lummox::Helpers::InstanceRegistry

  attr_reader :pointer

  def initialize(joystick_index)
    ensure_game_controller!(joystick_index)

    @pointer = create_managed_pointer(joystick_index)
    self.class.register_instance(@pointer.address, self)
  end

  def self.from_instance_id(joystick_instance_id)
    pointer = Lummox::SDL::Core.game_controller_from_instance_id(joystick_instance_id)
    find_instance(pointer.address)
  end

  def close!
    self.class.deregister_instance(@pointer.address)
    Lummox::SDL::Core.game_controller_close(@pointer)
    @pointer = FFI::Pointer::NULL
  end

  def name
    Lummox::SDL::Core.game_controller_name(@pointer)
  end

  def attached?
    Lummox::SDL::Core.game_controller_get_attached(@pointer) == :true
  end

  def position(axis)
    return axis_position(axis) if AXES.include?(axis)

    raise Lummox::SDLError, "Unknown axis '#{axis}'"
  end

  def pressed?(button)
    return button_pressed?(button) if BUTTONS.include?(button)

    raise Lummox::SDLError, "Unknown button '#{button}'"
  end

  private

  def ensure_game_controller!(joystick_index)
    return if Lummox::SDL::Core.is_game_controller(joystick_index) == :true

    raise Lummox::SDLError, "Joystick at index #{joystick_index} is not a GameController"
  end

  def create_managed_pointer(joystick_index)
    pointer = Lummox::SDLError.raise_if(:null?) { Lummox::SDL::Core.game_controller_open(joystick_index) }
    FFI::AutoPointer.new(pointer, method(:close!))
  end

  def button_pressed?(button)
    # TRICKY: This might be an error, but it's oppressively hard to check
    Lummox::SDL::Core.game_controller_get_button(@pointer, button) == :pressed
  end

  def axis_position(axis)
    # TRICKY: This might be an error, but it's oppressively hard to check
    Lummox::SDL::Core.game_controller_get_axis(@pointer, axis)
  end
end

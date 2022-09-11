# frozen_string_literal: true

class Lummox::Event::KeyboardEvent < Lummox::Event
  SDL_EVENT_FIELD = :keyboard_event

  def_delegators :sdl_event, :window_id, :state, :repeat, :keysym

  def window
    @window ||= Lummox::Window.from_id(window_id)
  end

  def pressed?
    state == :pressed
  end

  def keycode
    keysym[:sym]
  end

  def scancode
    keysym[:scancode]
  end

  def name
    @name ||= Lummox::Keyboard.name_for(keycode)
  end

  def inspect
    "#<#{self.class} type=#{type} keycode=#{keycode} scancode=#{scancode}>"
  end
end

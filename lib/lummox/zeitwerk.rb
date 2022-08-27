# frozen_string_literal: true

require "zeitwerk"

module_dir = File.realpath("#{__dir__}/..")
module_file = "#{module_dir}/lummox.rb"

Zeitwerk::Loader.new.tap do |loader|
  loader.tag = "lummox"
  loader.inflector = Zeitwerk::GemInflector.new(module_file).tap do |inflector|
    inflector.inflect(
      "io" => "IO",
      "rw_ops" => "RWOps",
      "rw_ops_type" => "RWOpsType",
      "rw_seek_position" => "RWSeekPosition",
      "sdl" => "SDL",
      "sdl_error" => "SDLError"
    )
  end
  loader.do_not_eager_load(__FILE__)
  loader.push_dir(File.realpath(module_dir))
  loader.setup
end

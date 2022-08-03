# frozen_string_literal: true

require "zeitwerk"

module_dir = File.realpath("#{__dir__}/../..")
module_file = "#{module_dir}/lummox/sdl.rb"

Zeitwerk::Loader.new.tap do |loader|
  loader.tag = "lummox-sdl"
  loader.inflector = Zeitwerk::GemInflector.new(module_file).tap do |inflector|
    inflector.inflect(
      "sdl" => "SDL"
    )
  end
  loader.do_not_eager_load(__FILE__)
  loader.push_dir(File.realpath(module_dir))
  loader.setup
end

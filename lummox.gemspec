# frozen_string_literal: true

require_relative "lib/lummox/version"

Gem::Specification.new do |spec|
  raise "RubyGems 2.0 or newer is required to protect against public gem pushes." unless spec.respond_to?(:metadata)

  spec.name = "lummox"
  spec.version = Lummox::VERSION
  spec.authors = ["Nate Eizenga"]
  spec.email = ["eizengan@gmail.com"]

  spec.summary = "A SDL-based game library"
  spec.homepage = "https://github.com/eizengan/lummox"
  spec.license = "zlib"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables += spec.files.grep(%r{\A#{spec.bindir}/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = [">= 2.6", "< 4"]

  spec.add_dependency "ffi", "~> 1.0"
  spec.add_dependency "zeitwerk", "~> 2.0"

  spec.add_development_dependency "pry-byebug", "~> 3.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "rubocop-performance", "~> 1.0"
  spec.add_development_dependency "rubocop-rake", "~> 0.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.0"
  spec.add_development_dependency "super_diff", "~> 0.0"
end


lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "space_missions/version"

Gem::Specification.new do |spec|
  spec.name          = "space_missions"
  spec.version       = SpaceMissions::VERSION
  spec.authors       = ["Joan Indiana Lyess"]
  spec.email         = ["joanrigdon@gmail.com"]
  spec.summary       = "Lists and lets user search NASA's Jet Propulsion Laboratory space missions."
  spec.homepage      = "https://github.com/joanrig/space_missions2.0"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri"
  spec.add_dependency "colorize"



end

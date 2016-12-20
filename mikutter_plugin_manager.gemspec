# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mikutter_plugin_manager/version'

Gem::Specification.new do |spec|
  spec.name          = "mikutter_plugin_manager"
  spec.version       = MikutterPluginManager::VERSION
  spec.authors       = ["arc680"]
  spec.email         = ["arc680@live.com"]

  spec.summary       = %q{mikutter プラグイン管理}
  spec.description   = %q{mikutter プラグインを管理する何か}
  spec.homepage      = "https://github.com/arc680/mikutter_plugin_manager"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "git", "~> 1.3"
  spec.add_dependency "thor", "~> 0.19.4"
end

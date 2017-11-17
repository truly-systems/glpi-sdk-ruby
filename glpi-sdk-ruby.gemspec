lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glpi/sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'glpi-sdk-ruby'
  spec.version       = GLPI::SDK::VERSION
  spec.authors       = ['Filipe Menezes']
  spec.email         = ['filipepmenezes@gmail.com']

  spec.summary       = 'GLPI SDK for Ruby'
  spec.description   = 'A Ruby library for the GLPI API'
  spec.homepage      = 'https://github.com/truly-systems/glpi-sdk-ruby'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'

  spec.add_runtime_dependency 'httparty'
end

# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'fountain/gem_version'

Gem::Specification.new do |spec|
  spec.name          = 'fountain'
  spec.version       = Fountain::VERSION
  spec.authors       = %w[abrom]
  spec.email         = %w[a.bromwich@gmail.com]

  spec.summary       = 'Fountain REST API v2 wrapper for Ruby'
  spec.description   = 'Fountain REST API v2 wrapper for Ruby'
  spec.homepage      = 'https://github.com/Studiosity/fountain-ruby'
  spec.license       = 'MIT'
  spec.required_ruby_version = ['>= 2.5.0', '< 3.2.0']

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|docs)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.5'
  spec.add_development_dependency 'simplecov', '~> 0.16', '< 0.18'
  spec.add_development_dependency 'webmock', '~> 2.3'
end

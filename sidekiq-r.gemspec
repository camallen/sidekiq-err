# frozen_string_literal: true

require_relative 'lib/sidekiq-r/version'

Gem::Specification.new do |spec|
  spec.name          = 'sidekiq-r'
  spec.version       = SidekiqR::VERSION
  spec.authors       = ['Campbell Allen']
  spec.email         = ['campbell.allen@gmail.com']

  spec.summary       = 'Status of your sidekiq system - useful for Kubernetes liveness probes'
  spec.description   = 'Status of your sidekiq system - useful for Kubernetes liveness probes'
  spec.homepage      = 'https://github.com/camallen/sidekiq-r'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files         = %w[lib/sidekiq-r.rb exe/sidekiq-r]
  spec.files         += Dir['lib/**/*.rb']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'sidekiq', '>= 5.0'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end

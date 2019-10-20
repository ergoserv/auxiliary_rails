lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auxiliary_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'auxiliary_rails'
  spec.version       = AuxiliaryRails::VERSION
  spec.authors       = ['Dmitry Babenko', 'ErgoServ']
  spec.email         = ['dmitry@ergoserv.com', 'hello@ergoserv.com']

  spec.summary       = 'AuxiliaryRails provides extra layers and utils ' \
    'for helping to build solid and clean Ruby on Rails applications'
  spec.description   = <<~DESC
    AuxiliaryRails is a collection of classes, configs, scripts,
    generators for Ruby on Rails helping you get things done, better.
  DESC
  spec.homepage      = 'https://github.com/ergoserv/auxiliary_rails'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = 'https://github.com/ergoserv/auxiliary_rails'
    spec.metadata['source_code_uri'] = 'https://github.com/ergoserv/auxiliary_rails'
    spec.metadata['changelog_uri'] = 'https://github.com/ergoserv/auxiliary_rails/blob/master/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required'
  end

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.executables   = ['auxiliary_rails']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rails', '>= 5.2', '< 7'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'

  spec.add_runtime_dependency 'dry-initializer-rails'
  spec.add_runtime_dependency 'thor'
end

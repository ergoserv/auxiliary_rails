lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auxiliary_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'auxiliary_rails'
  spec.version       = AuxiliaryRails::VERSION
  spec.authors       = ['Dmitry Babenko', 'ErgoServ']
  spec.email         = ['dmitry@ergoserv.com', 'hello@ergoserv.com']

  spec.summary = <<~DESC
    AuxiliaryRails provides extra layers and utils
    for helping to build solid and clean Ruby on Rails applications
  DESC
  spec.description = <<~DESC
    AuxiliaryRails is a collection of classes, configs, scripts,
    generators for Ruby on Rails helping you get things done, better.
  DESC
  spec.homepage      = 'https://github.com/ergoserv/auxiliary_rails'
  spec.license       = 'MIT'

  raise 'RubyGems 2.0 or newer is required' unless spec.respond_to?(:metadata)

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/releases"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.executables   = ['auxiliary_rails']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5'

  spec.add_dependency 'dry-core'
  spec.add_dependency 'dry-initializer'
  spec.add_dependency 'dry-initializer-rails'
  spec.add_dependency 'rails', '>= 5.2'
  spec.add_dependency 'thor'
end

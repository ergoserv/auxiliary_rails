require 'rails'

module AuxiliaryRails
  class InstallRubocopGenerator < ::Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def copy_config_file
      copy_file 'rubocop_template.yml', '.rubocop.yml'
    end

    def specify_gem_dependency
      gem_group :development, :test do
        gem 'rubocop'
      end
    end
  end
end

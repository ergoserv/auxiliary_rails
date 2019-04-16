require 'rails'

module AuxiliaryRails
  class InstallRubocopGenerator < ::Rails::Generators::Base
    class_option :specify_gems,
      type: :boolean,
      default: true,
      desc: 'Indicates if `rubocop` gem needs to be added to Gemfile'
    source_root File.expand_path('templates/rubocop', __dir__)

    def copy_config_files
      copy_file 'rubocop_template.yml',
        '.rubocop.yml'
      copy_file 'rubocop_auxiliary_rails_template.yml',
        '.rubocop_auxiliary_rails.yml'
    end

    def specify_gems_dependency
      return unless options[:specify_gems]

      gem_group :development, :test do
        gem 'rubocop'
        gem 'rubocop-rspec'
      end
    end
  end
end

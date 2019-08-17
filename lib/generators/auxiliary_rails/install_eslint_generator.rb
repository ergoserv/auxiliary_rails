require 'rails'

module AuxiliaryRails
  class InstallEslintGenerator < ::Rails::Generators::Base
    PACKAGES = %w[
      eslint
      eslint-config-standard
      eslint-plugin-standard
      eslint-plugin-promise
      eslint-plugin-import
      eslint-plugin-node
    ].freeze

    source_root File.expand_path('templates/eslint', __dir__)

    def copy_config_files
      copy_file 'eslintrc_template.yml',
        '.eslintrc.yml'
    end

    def install_elint_packages
      run 'yarn add -D ' + PACKAGES.join(' ')
    end

    def show_instructions
      say %(
        Run `eslint` using this command:
        => yarn run eslint --ext .js app/assets/javascripts
      )
    end
  end
end

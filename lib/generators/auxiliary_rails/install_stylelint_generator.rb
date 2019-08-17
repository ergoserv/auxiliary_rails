require 'rails'

module AuxiliaryRails
  class InstallStylelintGenerator < ::Rails::Generators::Base
    PACKAGES = %w[
      stylelint
      stylelint-config-standard
    ].freeze

    source_root File.expand_path('templates/stylelint', __dir__)

    def copy_config_files
      copy_file 'stylelintrc_template.yml',
        '.stylelintrc.yml'
    end

    def install_stylelint_packages
      run 'yarn add -D ' + PACKAGES.join(' ')
    end

    def show_instructions
      say %(
        Run `stylelint` using this command:
        => yarn run stylelint app/assets/stylesheets/
      )
    end
  end
end

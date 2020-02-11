require 'rails'

module AuxiliaryRails
  class InstallCommandsGenerator < ::Rails::Generators::Base
    source_root File.expand_path('templates/commands', __dir__)

    def copy_application_command_file
      copy_file 'application_command_template.rb',
        'app/commands/application_command.rb'
    end

    def copy_locale_command_file
      copy_file 'commands.en_template.yml',
        'config/locales/commands.en.yml'
    end
  end
end

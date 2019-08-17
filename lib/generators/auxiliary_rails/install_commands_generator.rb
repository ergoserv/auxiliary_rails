require 'rails'

module AuxiliaryRails
  class InstallCommandsGenerator < ::Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def copy_application_command_file
      copy_file 'application_command_template.rb',
        'app/commands/application_command.rb'
    end
  end
end

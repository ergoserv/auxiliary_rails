require 'rails'

module AuxiliaryRails
  class InstallErrorsGenerator < ::Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def copy_application_error_file
      copy_file 'application_error_template.rb',
                'app/errors/application_error.rb'
    end
  end
end

require 'rails'

module AuxiliaryRails
  class InstallErrorsControllerGenerator < ::Rails::Generators::Base
    source_root File.expand_path('templates/errors_controller', __dir__)

    VIEW_TEMPLATES = %w[error not_found_error unacceptable_error].freeze

    def copy_controller_file
      copy_file 'errors_controller_template.rb',
        'app/controllers/errors_controller.rb'
    end

    def copy_view_files
      VIEW_TEMPLATES.each do |tempate_name|
        copy_file "#{tempate_name}_template.html.erb",
          "app/views/errors/#{tempate_name}.html.erb"
      end
    end

    def add_route
      route "match '/404', to: 'errors#not_found_error', via: :all"
      route "match '/422', to: 'errors#unacceptable_error', via: :all"
      route "match '/500', to: 'errors#error', via: :all"
    end

    def add_exceptions_app_config
      application 'config.exceptions_app = routes'
    end
  end
end

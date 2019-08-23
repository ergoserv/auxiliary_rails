require 'rails'

module AuxiliaryRails
  class ApiResourceGenerator < ::Rails::Generators::NamedBase
    desc 'Stubs out a new API resource including an empty entity and spec.'

    class_option :api_module,
      type: :string,
      default: 'app',
      desc: 'API module name'
    class_option :api_version,
      type: :numeric,
      default: 1,
      desc: 'API version'
    class_option :skip_helper,
      type: :boolean,
      default: true,
      desc: 'Indicates if helper generation needs to be skipped'
    source_root File.expand_path('templates/apis', __dir__)

    def create_api_resource_file
      template 'api_resource_template.rb.erb',
        "app/#{api_module_path}/resources/#{plural_file_name}_resource.rb"
    end

    def create_api_entity_file
      template 'api_entity_template.rb.erb',
        "app/#{api_module_path}/entities/#{file_name}_entity.rb"
    end

    def create_api_helper_file
      return if options[:skip_helper]

      template 'api_helper_template.rb.erb',
        "app/#{api_module_path}/helpers/#{plural_file_name}_api_helper.rb"
    end

    def create_api_resource_spec_file
      template 'api_resource_spec_template.rb.erb',
        "spec/#{api_module_path}/resources/#{plural_file_name}_resource_spec.rb"
    end

    private

    def api_module_name
      "#{options[:api_module].camelize}V#{options[:api_version]}API"
    end

    def api_module_path
      "apis/#{options[:api_module]}_v#{options[:api_version]}_api"
    end

    def api_url_path
      api_name = 'api'
      api_name += "-#{options[:api_module]}" if options[:api_module] != 'app'
      "/#{api_name}/v#{options[:api_version]}/#{plural_name}"
    end

    def entity_class_name
      "#{api_module_name}::Entities::#{class_name}Entity"
    end
  end
end

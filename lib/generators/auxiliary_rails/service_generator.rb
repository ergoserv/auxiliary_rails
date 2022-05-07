require 'rails'

module AuxiliaryRails
  class ServiceGenerator < ::Rails::Generators::NamedBase
    desc 'Stubs out a new Service and spec.'

    source_root File.expand_path('templates/services', __dir__)

    class_option :path,
      type: :string,
      default: 'app/services',
      desc: 'Service location'

    def create_service_dir
      FileUtils.mkdir_p("#{service_file_path}/#{service_file_name}")
    end

    def create_service_file
      FileUtils.mkdir_p(service_file_path)
      template 'service_template.rb',
        "#{service_file_path}/#{service_file_name}.rb"
    end

    def create_service_spec_file
      FileUtils.mkdir_p(service_spec_path)
      template 'service_spec_template.rb',
        "#{service_spec_path}/#{service_file_name}_spec.rb"
    end

    private

    def service_module_name
      "#{class_name.gsub(/Service$/, '')}Service"
    end

    def service_file_name
      service_module_name.underscore
    end

    def service_file_path
      options[:path]
    end

    def service_spec_path
      service_file_path.gsub(%r{^app/}, 'spec/')
    end
  end
end

require 'rails'

module AuxiliaryRails
  class CommandGenerator < ::Rails::Generators::NamedBase
    desc 'Stubs out a new Command and spec.'

    source_root File.expand_path('templates/commands', __dir__)

    class_option :path,
      type: :string,
      default: 'app/commands',
      desc: 'Command location'

    def create_command_file
      FileUtils.mkdir_p(command_file_path)
      template 'command_template.rb',
        "#{command_file_path}/#{command_file_name}.rb"
    end

    def create_command_spec_file
      FileUtils.mkdir_p(command_spec_path)
      template 'command_spec_template.rb',
        "#{command_spec_path}/#{command_file_name}_spec.rb"
    end

    private

    def command_class_name
      "#{class_name.gsub(/Command$/, '')}Command"
    end

    def command_file_name
      command_class_name.underscore
    end

    def command_file_path
      options[:path]
    end

    def command_spec_path
      command_file_path.gsub(%r{^app/}, 'spec/')
    end
  end
end

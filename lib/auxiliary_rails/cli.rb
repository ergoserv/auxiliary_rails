require 'thor'

module AuxiliaryRails
  class CLI < Thor
    include Thor::Actions

    TEMPLATES_DIR =
      File.expand_path("#{__dir__}/../../templates/")

    desc 'new APP_PATH', 'Create Rails application from template'
    long_desc <<-LONGDESC
      Create Rails application from the specified template.
      Works like a wrapper for `rails new` command.

      Example: auxiliary_rails new ~/Code/weblog
    LONGDESC
    option :database,
      default: 'postgresql',
      type: :string
    option :template_name,
      default: 'elementary',
      type: :string
    def new(app_path)
      run "rails new #{app_path} " \
        '--skip-action-cable --skip-coffee --skip-test ' \
        "--database=#{options[:database]} " \
        "--template=#{rails_template_path(options[:template_name])}"
    end

    private

    def rails_template_path(template_name)
      "#{TEMPLATES_DIR}/rails/#{template_name}.rb"
    end
  end
end

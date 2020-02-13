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
    option :template,
      default: 'elementary',
      type: :string
    def new(app_path)
      run "rails new #{app_path} " \
        "--database=#{options[:database]} " \
        "--template=#{rails_template_path(options[:template])}" \
        '--skip-action-cable ' \
        '--skip-coffee ' \
        '--skip-test ' \
        '--skip-webpack-install'
    end

    private

    def rails_template_path(template)
      "#{TEMPLATES_DIR}/rails/#{template}.rb"
    end
  end
end

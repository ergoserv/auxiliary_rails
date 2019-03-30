require 'thor'

module AuxiliaryRails
  class CLI < Thor
    include Thor::Actions

    RAILS_APP_TEMPLATE =
      File.expand_path("#{__dir__}/../../templates/rails/template.rb")

    desc 'create_rails_app APP_PATH', 'Create Rails application from template'
    long_desc <<-LONGDESC
      Creates Rails application from template:
      #{RAILS_APP_TEMPLATE}

      Example: auxiliary_rails create_rails_app ~/Code/weblog
    LONGDESC
    def create_rails_app(app_path)
      run "rails new #{app_path} " \
        '--skip-action-cable --skip-coffee --skip-test --database=postgresql ' \
        "--template=#{RAILS_APP_TEMPLATE}"
    end
  end
end

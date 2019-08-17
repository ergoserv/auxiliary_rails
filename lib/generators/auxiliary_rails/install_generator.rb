require 'rails'

module AuxiliaryRails
  class InstallGenerator < ::Rails::Generators::Base
    def install
      generate 'auxiliary_rails:install_commands'
      generate 'auxiliary_rails:install_errors'
      generate 'auxiliary_rails:install_rubocop --no-specify-gems'
    end
  end
end

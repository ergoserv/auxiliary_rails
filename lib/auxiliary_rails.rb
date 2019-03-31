require 'auxiliary_rails/abstract_error'
require 'auxiliary_rails/abstract_command'
require 'auxiliary_rails/railtie' if defined?(Rails)
require 'auxiliary_rails/version'

module AuxiliaryRails
  class Error < StandardError; end
end

require 'auxiliary_rails/application/command'
require 'auxiliary_rails/application/error'
require 'auxiliary_rails/application/form'
require 'auxiliary_rails/application/service'
require 'auxiliary_rails/application/query'

require 'auxiliary_rails/railtie'
require 'auxiliary_rails/version'

module AuxiliaryRails
  class Error < StandardError; end
end

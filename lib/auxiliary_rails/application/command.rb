require 'active_model'
require 'auxiliary_rails/concerns/performable'
require 'dry-initializer-rails'

module AuxiliaryRails
  module Application
    class Command
      extend Dry::Initializer
      include ActiveModel::Validations
      include AuxiliaryRails::Concerns::Performable

      class << self
        alias argument param

        # Method for ActiveModel::Translation
        def i18n_scope
          :commands
        end
      end

      # Method for ActiveModel::Errors
      def read_attribute_for_validation(attr_name)
        attr_name = attr_name.to_sym
        if attr_name == :command
          self
        else
          arguments[attr_name]
        end
      end

      protected

      def arguments
        self.class.dry_initializer.attributes(self)
      end
    end
  end
end

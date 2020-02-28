require 'active_model'
require 'auxiliary_rails/concerns/performable'
require 'dry-initializer-rails'

module AuxiliaryRails
  module Application
    class Command
      extend Dry::Initializer
      include AuxiliaryRails::Concerns::Performable

      class << self
        def call(*args)
          new(*args).call
        end

        # Method for ActiveModel::Translation
        def i18n_scope
          :commands
        end
      end

      protected

      def arguments
        self.class.dry_initializer.attributes(self)
      end
    end
  end
end

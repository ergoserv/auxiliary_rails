require 'active_model'
require 'auxiliary_rails/concerns/performable'
require 'dry-initializer-rails'

module AuxiliaryRails
  module Application
    # @abstract
    class Command
      extend Dry::Initializer
      include AuxiliaryRails::Concerns::Performable

      class << self
        # @!method param(name, options = {})
        #   Defines param using <tt>Dry::Initializer</tt> format.
        #
        #   @see Dry::Initializer
        #   @see https://dry-rb.org/gems/dry-initializer/3.0/params-and-options/
        #
        #   @param name [Symbol]
        #   @param options [Hash]

        # @!method option(name, options = {})
        #   Defines option using <tt>Dry::Initializer</tt> format.

        #   @see Dry::Initializer
        #   @see https://dry-rb.org/gems/dry-initializer/3.0/params-and-options/
        #
        #   @param name [Symbol]
        #   @param options [Hash]

        # Initializes command with <tt>args</tt> and runs <tt>#call</tt> method.
        #
        # @return [self]
        def call(*args)
          new(*args).call
        end

        # Defines `scope` for <tt>ActiveModel::Translation</tt>
        #
        # @return [Symbol]
        def i18n_scope
          :commands
        end
      end

      def on(status, &_block)
        ensure_execution!

        return self unless status?(status)

        yield(self) if block_given?

        self
      end

      protected

      # Shortcut reader for attributes defined by <tt>Dry::Initializer</tt>
      #
      # @return [Hash]
      def arguments
        self.class.dry_initializer.attributes(self)
      end
    end
  end
end

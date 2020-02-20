require 'dry/core/class_attributes'
require 'dry-initializer'

module AuxiliaryRails
  module Application
    class Query
      extend Dry::Core::ClassAttributes
      extend Dry::Initializer

      defines :default_relation

      option :relation, default: proc { nil }

      def self.call(*args)
        new(*args).call
      end

      def call
        ensure_proper_relation_types!

        perform

        query
      end

      def perform
        raise NotImplementedError
      end

      def method_missing(method_name, *args, &block)
        super unless query.respond_to?(method_name)

        query.send(method_name, *args, &block)
      end

      def respond_to_missing?(method_name, include_private = false)
        query.respond_to?(method_name) || super
      end

      private

      # rubocop:disable Metrics/AbcSize, Style/GuardClause
      def ensure_proper_relation_types!
        if self.class.default_relation.nil?
          error!('Undefined `default_relation`')
        end
        if !queriable_object?(self.class.default_relation)
          error!('Invalid class of `default_relation`')
        end
        if !relation.nil? && !queriable_object?(relation)
          error!('Invalid class of `relation` option')
        end
      end
      # rubocop:enable Metrics/AbcSize, Style/GuardClause

      def error!(message = nil)
        raise error_class,
          "`#{self.class}` #{message || 'Query raised an error.'}"
      end

      def error_class
        AuxiliaryRails::Application::Error
      end

      def queriable_object?(object)
        object.is_a?(ActiveRecord::Relation)
      end

      def query(scoped_query = nil)
        @query ||= (relation || self.class.default_relation)

        @query = scoped_query unless scoped_query.nil?

        @query
      end
    end
  end
end

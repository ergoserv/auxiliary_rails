require 'auxiliary_rails/concerns/callable'
require 'auxiliary_rails/concerns/errorable'
require 'dry/core/class_attributes'
require 'dry-initializer'

module AuxiliaryRails
  module Application
    # @abstract
    class Query
      extend Dry::Core::ClassAttributes
      extend Dry::Initializer
      include AuxiliaryRails::Concerns::Callable
      include AuxiliaryRails::Concerns::Errorable

      defines :default_relation

      option :relation, default: proc {}

      def call
        ensure_proper_relation_types!

        perform

        if !queriable_object?(query)
          error!('Invalid class of resulted query')
        end

        query
      end

      # @abstract
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

      # rubocop:disable Style/GuardClause
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
      # rubocop:enable Style/GuardClause

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

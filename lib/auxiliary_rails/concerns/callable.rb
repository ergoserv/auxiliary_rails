module AuxiliaryRails
  module Concerns
    module Callable
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def call(*args)
          new(*args).call
        end
      end

      # @abstract
      def call
        raise NotImplementedError
      end
    end
  end
end

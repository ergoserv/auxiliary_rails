module AuxiliaryRails
  module Concerns
    module Callable
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        # Initializes object and runs <tt>#call</tt> method.
        #
        # @return [self]
        def call(*args, **kws)
          new(*args, **kws).call
        end
      end

      # @abstract
      def call
        raise NotImplementedError
      end
    end
  end
end

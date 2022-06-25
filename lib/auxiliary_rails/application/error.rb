module AuxiliaryRails
  module Application
    # @abstract
    class Error < RuntimeError
      attr_accessor :context
      attr_reader :exception
      attr_reader :severity

      def initialize(message = nil, context: nil, exception: nil, severity: nil)
        super message

        @context = context || {}
        @exception = exception
        @severity = severity || :error
      end

      def report
        raise NotImplementedError
      end

      # @return [self] Wraps exception into a new Application Error object
      def self.wrap(exception, context: nil)
        new(exception.message, context: context, exception: exception)
      end
    end
  end
end

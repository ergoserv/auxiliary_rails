module AuxiliaryRails
  module Application
    # @abstract
    class Error < RuntimeError
      attr_accessor :context
      attr_reader :exception, :severity

      def initialize(message = nil, context: nil, exception: nil, severity: nil)
        super message

        @context = context || {}
        @exception = exception
        @severity = severity || :error
      end

      def friendly_message
        I18n.t(:default,
          scope: self.class.i18n_scope,
          default: 'We are sorry, but something went wrong.')
      end

      def report
        raise NotImplementedError
      end

      class << self
        def i18n_scope
          "errors.#{name.underscore}"
        end

        # @return [self] Wraps exception into a new Application Error object
        def wrap(exception, context: nil)
          new(exception.message, context: context, exception: exception)
        end
      end
    end
  end
end

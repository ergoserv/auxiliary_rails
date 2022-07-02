module AuxiliaryRails
  module Application
    # @abstract
    class Error < RuntimeError
      attr_accessor :context
      attr_reader :exception, :severity

      class << self
        def i18n_scope
          "errors.#{name.underscore}"
        end

        # @return [self] Wraps exception into a new Application Error object
        def wrap(exception, context: nil)
          new(exception.message, context: context, exception: exception)
        end
      end

      def initialize(message = nil, context: nil, exception: nil, severity: nil)
        super message

        self.context = default_context.merge(context || {})
        self.exception = exception
        self.severity = severity || default_severity
      end

      def default_context
        {}
      end

      def default_severity
        :error
      end

      def friendly_message
        I18n.t(:default,
          scope: self.class.i18n_scope,
          default: 'We are sorry, but something went wrong.')
      end

      def report
        raise NotImplementedError
      end

      private

      attr_writer :exception, :severity
    end
  end
end

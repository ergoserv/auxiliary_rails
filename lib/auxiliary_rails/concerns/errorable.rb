module AuxiliaryRails
  module Concerns
    module Errorable
      # extend ActiveSupport::Concern

      def error!(message = nil)
        message ||= "`#{self.class}` raised error."
        raise error_class, message
      end

      if defined?(ApplicationError)
        def error_class
          ApplicationError
        end
      else
        def error_class
          AuxiliaryRails::Application::Error
        end
      end
    end
  end
end

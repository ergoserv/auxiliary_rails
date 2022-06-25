module AuxiliaryRails
  module Concerns
    module Errorable
      extend ActiveSupport::Concern

      class_methods do
        def error_class
          if Object.const_defined?(:ApplicationError)
            ApplicationError
          else
            AuxiliaryRails::Application::Error
          end
        end
      end

      def error!(message = nil)
        message ||= "`#{self.class}` raised error."
        raise self.class.error_class, message
      end
    end
  end
end

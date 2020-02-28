require 'active_support/concern'

module AuxiliaryRails
  module Concerns
    module Performable
      extend ActiveSupport::Concern
      include ActiveModel::Validations

      class_methods do
        def call(*args)
          new(*args).call
        end
      end

      def call(options = {})
        ensure_empty_status!

        if options[:validate!] == true
          validate!
        elsif options[:validate] != false && invalid?
          return failure!(:validation_failed)
        end

        perform

        ensure_execution!
        self
      end

      def perform
        raise NotImplementedError
      end

      def failure?
        status?(:failure)
      end

      def status?(value)
        ensure_execution!

        performable_status == value&.to_sym
      end

      def success?
        status?(:success)
      end

      # Shortcut for `ActiveRecord::Base.transaction`
      def transaction(&block)
        ActiveRecord::Base.transaction(&block) if block_given?
      end

      protected

      attr_accessor :performable_status

      def ensure_empty_errors!
        return if errors.empty?

        error!("`#{self.class}` contains errors.")
      end

      def ensure_empty_status!
        return if performable_status.nil?

        error!("`#{self.class}` was already executed.")
      end

      def ensure_execution!
        return if performable_status.present?

        error!("`#{self.class}` was not executed yet.")
      end

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

      def failure!(message = nil, options = {})
        ensure_empty_status!

        errors.add(:base, message, options) if message.present?

        self.performable_status = :failure
        self
      end

      def success!
        ensure_empty_errors!
        ensure_empty_status!

        self.performable_status = :success
        self
      end
    end
  end
end

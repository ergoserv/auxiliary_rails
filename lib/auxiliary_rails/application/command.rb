require 'active_model'
require 'dry-initializer-rails'

module AuxiliaryRails
  module Application
    class Command
      extend Dry::Initializer
      include ActiveModel::Validations

      class << self
        alias argument param

        def call(*args)
          new(*args).call
        end

        # Method for ActiveModel::Translation
        def i18n_scope
          :commands
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

        command_status == value&.to_sym
      end

      def success?
        status?(:success)
      end

      # Shortcut for `ActiveRecord::Base.transaction`
      def transaction(&block)
        ActiveRecord::Base.transaction(&block) if block_given?
      end

      # Method for ActiveModel::Errors
      def read_attribute_for_validation(attr_name)
        attr_name = attr_name.to_sym
        if attr_name == :command
          self
        else
          arguments[attr_name]
        end
      end

      protected

      attr_accessor :command_status

      def arguments
        self.class.dry_initializer.attributes(self)
      end

      def ensure_empty_errors!
        return if errors.empty?

        error!("`#{self.class}` contains errors.")
      end

      def ensure_empty_status!
        return if command_status.nil?

        error!("`#{self.class}` was already executed.")
      end

      def ensure_execution!
        return if command_status.present?

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

        errors.add(:command, message, options) if message.present?

        self.command_status = :failure
        self
      end

      def success!
        ensure_empty_errors!
        ensure_empty_status!

        self.command_status = :success
        self
      end
    end
  end
end

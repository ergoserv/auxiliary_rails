require 'active_support/concern'
require 'auxiliary_rails/concerns/errorable'

module AuxiliaryRails
  module Concerns
    module Performable
      extend ActiveSupport::Concern
      include ActiveModel::Validations
      include AuxiliaryRails::Concerns::Errorable

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
          return failure!
        end

        perform

        ensure_execution!
        self
      end

      # Describes business logic.
      #
      # Method <b>should always</b> return <tt>success!</tt>
      # or <tt>failure!</tt> methods in order pro provide further
      # correct method chaining.
      #
      # @abstract
      # @return [self]
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

      # Provides ability to execude block of the code depending on
      # command execution status
      #
      # @param status [Symol] Desired command status
      # @param &block Code to be executed if status matches
      # @return [self]
      def on(status, &block)
        ensure_execution!

        return self unless status?(status)

        yield(self) if block

        self
      end

      # Shortcut for <tt>ActiveRecord::Base.transaction</tt>
      def transaction(&block)
        ActiveRecord::Base.transaction(&block) if block
      end

      protected

      attr_accessor :performable_status

      # @raise [AuxiliaryRails::Application::Error]
      #   Error happens if command contains any errors.
      # @return [nil]
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

      # Sets command's status to <tt>failure</tt>.
      #
      # @return [self]
      def failure!(message = nil, options = {})
        ensure_empty_status!

        errors.add(:base, message, options) if message.present?

        self.performable_status = :failure
        self
      end

      # Sets command's status to <tt>success</tt>.
      #
      # @return [self]
      def success!
        ensure_empty_errors!
        ensure_empty_status!

        self.performable_status = :success
        self
      end
    end
  end
end

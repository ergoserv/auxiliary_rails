require 'dry-initializer-rails'
require 'active_model'

module AuxiliaryRails
  class AbstractCommand
    extend Dry::Initializer
    include ActiveModel::Validations

    def self.call(*args)
      new(*args).call
    end

    def call
      raise NotImplementedError
    end

    def failure?
      status?(:failure)
    end

    def status?(value)
      ensure_execution!

      status == value&.to_sym
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
        self.class.dry_initializer.attributes(self)[attr_name]
      end
    end

    # Method for ActiveModel::Translation
    def self.i18n_scope
      :commands
    end

    protected

    attr_accessor :status

    def ensure_empty_errors!
      return if errors.empty?

      error!("`#{self.class}` contains errors.")
    end

    def ensure_empty_status!
      return if status.nil?

      error!("`#{self.class}` was already executed.")
    end

    def ensure_execution!
      return if status.present?

      error!("`#{self.class}` was not executed yet.")
    end

    def error!(message = nil)
      message ||= "`#{self.class}` raised error."
      raise ApplicationError, message
    end

    def failure!(message = nil)
      ensure_empty_status!

      errors.add(:command, :failed, message: message) unless message.nil?

      self.status = :failure
      self
    end

    def success!
      ensure_empty_errors!
      ensure_empty_status!

      self.status = :success
      self
    end
  end
end

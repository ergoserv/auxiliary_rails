class ApplicationError < AuxiliaryRails::AbstractError
end

module SampleCommands
  class SuccessCommand < AuxiliaryRails::AbstractCommand
    def call
      success!
    end
  end

  class DoubleStatusSetCommand < AuxiliaryRails::AbstractCommand
    def call
      failure!
      success!
    end
  end

  class SuccessWithErrorsCommand < AuxiliaryRails::AbstractCommand
    def call
      errors.add(:command, :error)
      success!
    end
  end

  class FailureWithErrorsCommand < AuxiliaryRails::AbstractCommand
    def call
      errors.add(:command, :test_failure_message)
      failure!
    end
  end

  class ValidationErrorsCommand < AuxiliaryRails::AbstractCommand
    param :age

    validates :age,
      numericality: {
        only_integer: true,
        greater_than: 18
      }

    def call
      return failure! unless valid?

      success!
    end
  end
end

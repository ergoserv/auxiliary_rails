class ApplicationError < AuxiliaryRails::AbstractError
end

module SampleCommands
  class SuccessCommand < AuxiliaryRails::AbstractCommand
    def perform
      success!
    end
  end

  class DoubleStatusSetCommand < AuxiliaryRails::AbstractCommand
    def perform
      failure!
      success!
    end
  end

  class SuccessWithErrorsCommand < AuxiliaryRails::AbstractCommand
    def perform
      errors.add(:command, :error)
      success!
    end
  end

  class FailureWithErrorsCommand < AuxiliaryRails::AbstractCommand
    def perform
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

    def perform
      return failure! unless valid?

      success!
    end
  end
end

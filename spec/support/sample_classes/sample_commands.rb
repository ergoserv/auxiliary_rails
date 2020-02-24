module SampleCommands
  class SuccessCommand < AuxiliaryRails::Application::Command
    def perform
      success!
    end
  end

  class DoubleStatusSetCommand < AuxiliaryRails::Application::Command
    def perform
      failure!
      success!
    end
  end

  class SuccessWithErrorsCommand < AuxiliaryRails::Application::Command
    def perform
      errors.add(:command, :error)
      success!
    end
  end

  class FailureWithErrorsCommand < AuxiliaryRails::Application::Command
    def perform
      errors.add(:command, :test_failure_message)
      failure!
    end
  end

  class ValidationErrorsCommand < AuxiliaryRails::Application::Command
    param :age

    validates :age,
      numericality: {
        only_integer: true,
        greater_than: 18
      }

    def perform
      success!
    end
  end
end

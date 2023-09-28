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
      errors.add(:base)
      success!
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

  class FailureMessageErrorsCommand < AuxiliaryRails::Application::Command
    def perform
      failure!('Custom failure message!', { foo: :bar })
    end
  end
end

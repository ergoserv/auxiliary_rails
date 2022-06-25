def stub_failed_command
  cmd_class = Class.new(described_class) do
    def perform
      errors.add(:base, :test_failure_message)
      failure!
    end
  end
  stub_const('FailedCommand', cmd_class)
end

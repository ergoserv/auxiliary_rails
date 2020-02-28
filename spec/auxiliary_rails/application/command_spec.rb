RSpec.describe AuxiliaryRails::Application::Command do
  describe '#call' do
    subject(:cmd_class) { described_class }

    it 'raises NotImplementedError exception' do
      expect { cmd_class.call }.to raise_error NotImplementedError
    end
  end

  describe '.call' do
    subject(:cmd) { described_class.new }

    it 'raises NotImplementedError exception' do
      expect { cmd.call }.to raise_error NotImplementedError
    end
  end

  describe '#on' do
    it 'provides access to caller methods' do
      def example_method; end

      SampleCommands::SuccessCommand.call
        .on(:success) do
          expect(self).to be_respond_to :example_method
        end
    end

    it 'provides interface to command object inside block' do
      SampleCommands::FailureWithErrorsCommand.call
        .on(:failure) do |cmd|
          expect(cmd.errors).to be_any
        end
    end
  end
end

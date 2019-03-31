require 'support/sample_classes/sample_commands'

RSpec.describe SampleCommands do
  describe 'SuccessCommand' do
    describe '#call' do
      subject(:cmd_class) { SampleCommands::SuccessCommand }

      it do
        expect(cmd_class.call).to be_a cmd_class
      end
    end

    describe '.call' do
      subject(:cmd) { SampleCommands::SuccessCommand.new }

      it 'returns self as a result' do
        expect(cmd.call).to be cmd
      end

      it do
        expect(cmd.call).to be_success
      end
    end
  end

  describe 'DoubleStatusSetCommand' do
    subject(:cmd) { SampleCommands::DoubleStatusSetCommand.new }

    describe '.call' do
      it do
        expect { cmd.call }.to raise_error ApplicationError,
          '`SampleCommands::DoubleStatusSetCommand` was already executed.'
      end
    end
  end

  describe 'SuccessWithErrorsCommand' do
    subject(:cmd) { SampleCommands::SuccessWithErrorsCommand.new }

    describe '.call' do
      it do
        expect { cmd.call }.to raise_error ApplicationError,
          '`SampleCommands::SuccessWithErrorsCommand` contains errors.'
      end
    end
  end

  describe 'FailureWithErrorsCommand' do
    subject(:cmd) { SampleCommands::FailureWithErrorsCommand.new }

    describe '.call' do
      it do
        expect { cmd.call }.to change(cmd.errors, :count).from(0).to(1)
      end

      it do
        puts cmd.call.errors.full_messages
      end
    end
  end
end

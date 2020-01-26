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

    describe '#call' do
      it do
        expect { cmd.call }.to raise_error AuxiliaryRails::Application::Error,
          '`SampleCommands::DoubleStatusSetCommand` was already executed.'
      end
    end
  end

  describe 'SuccessWithErrorsCommand' do
    subject(:cmd) { SampleCommands::SuccessWithErrorsCommand.new }

    describe '#call' do
      it do
        expect { cmd.call }.to raise_error AuxiliaryRails::Application::Error,
          '`SampleCommands::SuccessWithErrorsCommand` contains errors.'
      end
    end
  end

  describe 'FailureWithErrorsCommand' do
    subject(:cmd) { SampleCommands::FailureWithErrorsCommand.new }

    describe '#call' do
      it do
        expect { cmd.call }.to change(cmd.errors, :count).from(0).to(1)
      end
    end
  end

  describe 'ValidationErrorsCommand' do
    subject(:cmd) { SampleCommands::ValidationErrorsCommand.new(age) }

    context 'when params are valid' do
      let(:age) { 19 }

      it 'succeeds without any errors' do
        expect(cmd.call).to be_success
        expect(cmd.errors.count).to eq 0
      end
    end

    context 'when params are not valid' do
      let(:age) { 17 }

      it do
        expect(cmd.call).to be_failure
        expect(cmd.errors[:age]).to include 'must be greater than 18'
      end

      context 'when option to skip validation set' do
        it do
          expect(cmd.call(validate: false)).to be_success
        end
      end
    end
  end
end

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
end

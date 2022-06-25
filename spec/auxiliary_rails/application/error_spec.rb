RSpec.describe AuxiliaryRails::Application::Error do
  describe '.i18n_scope' do
    subject(:error_class) { described_class }

    it do
      expect(error_class.i18n_scope).to eq 'errors.auxiliary_rails/application/error'
    end

    context 'when ApplicationError' do
      subject(:error_class) { ApplicationError }

      before do
        application_error_class = Class.new(described_class)
        stub_const('ApplicationError', application_error_class)
      end

      it do
        expect(error_class.i18n_scope).to eq 'errors.application_error'
      end
    end

    context 'when SomeService::Error' do
      subject(:error_class) { SomeService::Error }

      before do
        service_error_class = Class.new(described_class)
        stub_const('SomeService::Error', service_error_class)
      end

      it do
        expect(error_class.i18n_scope).to eq 'errors.some_service/error'
      end
    end
  end

  describe '#friendly_message' do
    subject(:error) { described_class.new }

    it 'responds with default message' do
      expect(error.friendly_message).to eq 'We are sorry, but something went wrong.'
    end
  end
end

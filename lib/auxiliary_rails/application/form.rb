require 'active_model'

module AuxiliaryRails
  module Application
    class Form
      include ActiveModel::Attributes
      include ActiveModel::Model

      class << self
        # Method for ActiveModel::Translation
        def i18n_scope
          :forms
        end
      end

      def submit
        raise NotImplementedError
      end
    end
  end
end

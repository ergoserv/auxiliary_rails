require 'active_model'

module AuxiliaryRails
  module Application
    class Form
      include ActiveModel::Attributes
      include ActiveModel::AttributeAssignment
      include ActiveModel::Model
      include AuxiliaryRails::Concerns::Performable

      class << self
        # Method for ActiveModel::Translation
        def i18n_scope
          :forms
        end
      end

      # Indicates object persistence.
      #
      # In case of form as performable object that means that form
      # was executed with success.
      def persisted?
        performable_status == true
      end
    end
  end
end

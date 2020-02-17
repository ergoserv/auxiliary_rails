require 'active_model'

module AuxiliaryRails
  module Application
    class Form
      include ActiveModel::Attributes
      include ActiveModel::AttributeAssignment
      include ActiveModel::Model
      include ActiveModel::Validations
      include AuxiliaryRails::Concerns::Performable

      class << self
        # Method for ActiveModel::Translation
        def i18n_scope
          :forms
        end
      end

      # Method for ActiveModel::Errors
      def read_attribute_for_validation(attr_name)
        if attr_name.to_sym == :form
          self
        else
          super
        end
      end
    end
  end
end

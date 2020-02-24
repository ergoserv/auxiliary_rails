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
    end
  end
end

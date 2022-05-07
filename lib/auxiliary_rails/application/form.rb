require 'active_model'
require 'auxiliary_rails/concerns/performable'

module AuxiliaryRails
  module Application
    # @abstract
    class Form
      include ActiveModel::Model
      include ActiveModel::Attributes
      include ActiveModel::AttributeAssignment
      include AuxiliaryRails::Concerns::Performable

      class << self
        # Defines `scope` for <tt>ActiveModel::Translation</tt>
        #
        # @return [Symbol]
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

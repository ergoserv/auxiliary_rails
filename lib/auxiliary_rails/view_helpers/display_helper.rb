module AuxiliaryRails
  module ViewHelpers
    module DisplayHelper
      DISPLAY_NAME_METHODS = %i[
        display_name
        name
        title
        full_name
        username
        email
      ].freeze

      def display_name(resource)
        return if resource.nil?

        DISPLAY_NAME_METHODS.each do |method_name|
          if resource.respond_to?(method_name)
            return resource.public_send(method_name)
          end
        end

        if resource.respond_to?(:model_name) && resource.respond_to?(:id)
          return "#{resource.model_name.human} ##{resource.id}"
        end

        resource.to_s
      end
    end
  end
end

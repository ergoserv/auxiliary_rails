require 'auxiliary_rails/view_helpers/display_helper'

module AuxiliaryRails
  module ViewHelpers
    include DisplayHelper

    def current_controller?(*ctrl_names)
      ctrl_names.include?(params[:controller])
    end

    def current_action?(*action_names)
      action_names.include?(params[:action])
    end
  end
end

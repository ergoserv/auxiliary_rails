Dir["#{File.expand_path('view_helpers', __dir__)}/*.rb"]
  .sort.each { |f| require f }

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

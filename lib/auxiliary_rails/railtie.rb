require 'rails/railtie'
require 'auxiliary_rails/view_helpers'

module AuxiliaryRails
  class Railtie < Rails::Railtie
    initializer 'auxiliary_rails.view_helpers' do
      ActionView::Base.include ViewHelpers
    end
  end
end

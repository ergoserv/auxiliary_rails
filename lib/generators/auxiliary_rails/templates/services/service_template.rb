module <%= service_module_name %>
  extend AuxiliaryRails::Application::Service

  module_function

  CONFIG = {
    key: 'value'
  }.freeze

end

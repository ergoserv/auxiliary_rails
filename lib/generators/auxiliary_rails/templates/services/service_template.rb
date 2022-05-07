module <%= service_module_name %>
  module_function

  include AuxiliaryRails::Concerns::ServiceConfigurable

  CONFIG = {
    key: 'value'
  }.freeze

end

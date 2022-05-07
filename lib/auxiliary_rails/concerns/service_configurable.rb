require 'active_support/concern'
require 'active_support/ordered_options'

module AuxiliaryRails
  module Concerns
    module ServiceConfigurable
      extend ActiveSupport::Concern

      class_methods do
        # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        def config
          return @config if @config.present?

          service_name = name.underscore

          # load from service config file
          if File.exist?(Rails.root.join("config/services/#{service_name}.yml"))
            return @config = Rails.application.config_for("services/#{service_name}")
          end

          # load from application config
          if Object.const_defined?(:Config) && Config.respond_to?(:const_name)
            app_config = Object.const_get(Config.const_name)
            if app_config.dig(:services, service_name).present?
              return @config = app_config[:services][service_name]
            end
          end

          # load from constant
          if const_defined?(:CONFIG)
            return @config = ActiveSupport::OrderedOptions.new.update(const_get(:CONFIG))
          end

          raise AuxiliaryRails::Error,
            "Unable to find suitable config for #{name} module"
        end
        # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
      end
    end
  end
end

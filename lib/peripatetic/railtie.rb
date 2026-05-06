require "rails"

module Peripatetic
  class Railtie < Rails::Railtie
    initializer "peripatetic.configure_geocoder" do
      Geocoder.configure(timeout: 3)
    end

    initializer "peripatetic.insert_into_active_record" do
      ActiveSupport.on_load(:active_record) do
        include Peripatetic
      end
    end

    initializer "peripatetic.action_view" do
      ActiveSupport.on_load(:action_view) do
        include Peripatetic::HelperMethods
      end
    end

    initializer "peripatetic.generators" do
      require "peripatetic/generators" if defined?(Rails::Generators)
    end
  end
end

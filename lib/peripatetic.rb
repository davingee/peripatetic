require "peripatetic/version"
require "active_record"
require "geocoder"
require "geocoder/models/active_record"
require "peripatetic/application_record"
require "peripatetic/railtie" if defined?(Rails)
require "peripatetic/location"
require "peripatetic/postal_code"
require "peripatetic/country"

module Peripatetic
  def self.included(base)
    base.extend ClassMethods

    base.class_eval do
      has_many :locations, as: :locationable, class_name: "Peripatetic::Location", dependent: :destroy
      accepts_nested_attributes_for :locations,
        reject_if: proc { |attrs| attrs[:accessor_postal_code].blank? },
        allow_destroy: true
    end
  end

  module ClassMethods
    def has_peripatetic_locations(options = {})
      has_many :locations,
        as: :locationable,
        class_name: "Peripatetic::Location",
        dependent: :destroy
      accepts_nested_attributes_for :locations,
        reject_if: proc { |attrs| attrs[:accessor_postal_code].blank? },
        allow_destroy: true
    end
  end

  module HelperMethods
    def all_countries
      Country.select(:id, :name, :position).order(position: :asc)
    end

    def ip_address
      Rails.env.local? ? "206.127.79.163" : (env["HTTP_X_REAL_IP"] || env["REMOTE_ADDR"])
    end

    def get_country
      if builder.object.accessor_postal_code.present?
        { ip: ip_address, country: builder.object.accessor_country, postal_code: builder.object.accessor_postal_code }
      else
        result = Geocoder.search(ip_address).first
        { ip: ip_address, country: result.country, postal_code: result.postal_code } if result
      end
    end

    def get_accessors(model)
      @get_accessors ||= get_accessor_postal_code(model)
    end

    def get_accessor_postal_code(model)
      if model.postal_code.blank?
        result = Geocoder.search(ip_address).first
        if result
          country = Country.select(:id, :name, :position).find_by(name: result.country) ||
                    Country.select(:id, :name, :position).find_by(name: "United States")
          model.country_id = country.id
          @get_accessor_postal_code = { ip: ip_address, postal_code: result.postal_code }
        else
          @get_accessor_postal_code = { ip: ip_address, postal_code: "" }
        end
      else
        @get_accessor_postal_code = { ip: ip_address, postal_code: model.postal_code }
      end
    end

    def peripatetic_locations(model, amount = false)
      if amount
        amount.times { model.locations.build } if model.new_record?
        :locations
      else
        model.locations.build
        :location
      end
    end
  end
end


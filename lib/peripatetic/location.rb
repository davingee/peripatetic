module Peripatetic
  class Location < ApplicationRecord
    attr_accessor :accessor_country, :accessor_postal_code, :ip

    belongs_to :locationable, polymorphic: true
    belongs_to :country, optional: true

    reverse_geocoded_by :latitude, :longitude
    geocoded_by :location_attributes_available do |obj, results|
      if (geo = results.first)
        obj.latitude  = geo.latitude  if geo.latitude
        obj.longitude = geo.longitude if geo.longitude
        obj.region    = geo.state if geo.state.present? && geo.state_code.present?
        obj.city      = geo.city&.downcase
        obj.geocoded  = true
      end
    end

    validates :postal_code, presence: true, if: :postal_code_changed?
    validate :validate_postal_code, if: :postal_code_changed?

    after_validation :geocode, if: :street_present_or_changed?
    after_validation :inject_location_info

    def validate_postal_code
      return if postal_code.blank? || country.blank?
      unless PostalCode.exists?(postal_code: accessor_postal_code, country_code: country.alpha2)
        errors.add(:postal_code, "appears to be invalid")
      end
    end

    def street?        = street.present?
    def city?          = city.present?
    def postal_code?   = postal_code.present?
    def accessor_postal_code? = accessor_postal_code.present?
    def region?        = region.present?
    def accessor_country?     = accessor_country.present?

    def inject_location_info
      return if accessor_postal_code.blank? || country.blank?
      return unless postal_code_changed? || new_record?

      p_c = PostalCode.find_by(
        postal_code: accessor_postal_code,
        country_code: country.alpha2
      )

      return if p_c.blank?

      self.postal_code  = p_c.postal_code
      self.city         = p_c.city
      self.region       = p_c.region
      self.country_code = p_c.country_code
      self.time_zone    = p_c.time_zone unless p_c.time_zone == "f"
      self.latitude     = p_c.latitude
      self.longitude    = p_c.longitude
    end

    def street_present_or_changed?
      street_changed? && street.present?
    end

    def location_attributes_available
      if street? && accessor_postal_code?
        "#{street} #{accessor_postal_code} #{accessor_country}"
      elsif accessor_postal_code?
        "#{accessor_postal_code} #{accessor_country}"
      elsif accessor_country?
        accessor_country
      else
        ip
      end
    end

    def city_address
      "#{city} #{region}"
    end

    def full_address
      "#{street} #{city} #{region} #{postal_code}".strip
    end
  end
end

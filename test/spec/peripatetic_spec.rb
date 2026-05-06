require 'spec_helper'

RSpec.describe Peripatetic do
  describe "Location model" do
    it "has valid attributes" do
      expect(Peripatetic::Location.new).to respond_to(:street)
      expect(Peripatetic::Location.new).to respond_to(:city)
      expect(Peripatetic::Location.new).to respond_to(:region)
      expect(Peripatetic::Location.new).to respond_to(:postal_code)
      expect(Peripatetic::Location.new).to respond_to(:latitude)
      expect(Peripatetic::Location.new).to respond_to(:longitude)
    end

    it "is polymorphic and belongs to locationable" do
      association = Peripatetic::Location.reflect_on_association(:locationable)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options).to include(polymorphic: true)
    end

    it "accepts nested attributes for locations" do
      expect(Peripatetic::Location.new).to respond_to(:locationable=)
    end
  end

  describe "Country model" do
    it "has valid attributes" do
      expect(Peripatetic::Country.new).to respond_to(:name)
      expect(Peripatetic::Country.new).to respond_to(:alpha2)
    end

    it "has many postal codes" do
      association = Peripatetic::Country.reflect_on_association(:postal_codes)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe "PostalCode model" do
    it "has valid attributes" do
      expect(Peripatetic::PostalCode.new).to respond_to(:postal_code)
      expect(Peripatetic::PostalCode.new).to respond_to(:city)
      expect(Peripatetic::PostalCode.new).to respond_to(:country_code)
      expect(Peripatetic::PostalCode.new).to respond_to(:latitude)
      expect(Peripatetic::PostalCode.new).to respond_to(:longitude)
      expect(Peripatetic::PostalCode.new).to respond_to(:time_zone)
    end

    it "belongs to country" do
      association = Peripatetic::PostalCode.reflect_on_association(:country)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "Module inclusion" do
    it "can be included in ActiveRecord models" do
      klass = Class.new(Peripatetic::ApplicationRecord) { include Peripatetic }
      expect(klass.included_modules).to include(Peripatetic)
    end

    it "adds has_many locations when included" do
      klass = Class.new(Peripatetic::ApplicationRecord) { include Peripatetic }
      expect(klass.reflect_on_association(:locations)).not_to be_nil
    end
  end
end

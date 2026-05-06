module Peripatetic
  class PostalCode < ApplicationRecord
    belongs_to :country, class_name: "Peripatetic::Country"

    validates :postal_code, presence: true
    validates :country_code, presence: true
    validates :city, presence: true
  end
end

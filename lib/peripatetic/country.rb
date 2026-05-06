module Peripatetic
  class Country < ApplicationRecord
    has_many :postal_codes, class_name: "Peripatetic::PostalCode", dependent: :destroy

    validates :name, presence: true
    validates :alpha2, presence: true, uniqueness: true
  end
end
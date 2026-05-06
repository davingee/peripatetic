require 'rspec'
require 'active_record'
require 'geocoder'
require 'geocoder/models/active_record'
require 'peripatetic'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :peripatetic_locations, force: true do |t|
    t.references :locationable, polymorphic: true
    t.integer    :country_id
    t.string     :street
    t.string     :city
    t.string     :region
    t.string     :postal_code
    t.string     :country_code
    t.string     :time_zone
    t.float      :latitude
    t.float      :longitude
    t.boolean    :geocoded, default: false
    t.timestamps null: false
  end

  create_table :peripatetic_countries, force: true do |t|
    t.string  :name, null: false
    t.string  :alpha2, null: false
    t.integer :position
    t.timestamps null: false
  end

  create_table :peripatetic_postal_codes, force: true do |t|
    t.integer :country_id
    t.string  :postal_code, null: false
    t.string  :city,        null: false
    t.string  :region
    t.string  :country_code, null: false
    t.string  :time_zone
    t.float   :latitude
    t.float   :longitude
    t.timestamps null: false
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.default_formatter = 'doc'
end

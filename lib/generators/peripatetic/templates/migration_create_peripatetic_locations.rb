class CreatePeripatheticLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :peripatetic_locations do |t|
      t.string :street
      t.string :city
      t.string :region
      t.string :region_code
      t.string :postal_code
      t.string :country_code
      t.string :time_zone
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.boolean :geocoded, default: false

      # Polymorphic association
      t.references :locationable, polymorphic: true, null: false
      t.references :country, foreign_key: { to_table: :peripatetic_countries }, null: true

      # IP geocoding
      t.string :ip

      t.timestamps
    end

    add_index :peripatetic_locations, [:locationable_type, :locationable_id]
    add_index :peripatetic_locations, [:postal_code, :country_code]
  end
end

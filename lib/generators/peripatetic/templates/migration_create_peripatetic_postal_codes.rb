class CreatePeripatheticPostalCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :peripatetic_postal_codes do |t|
      t.string :postal_code, null: false
      t.string :city, null: false
      t.string :region
      t.string :region_code
      t.string :country_code, null: false
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :time_zone
      
      t.references :country, foreign_key: { to_table: :peripatetic_countries }, null: true

      t.timestamps
    end

    # Composite index for postal code lookups
    add_index :peripatetic_postal_codes, [:postal_code, :country_code], unique: true\n    add_index :peripatetic_postal_codes, :country_code\n    add_index :peripatetic_postal_codes, :city\n  end\nend\n
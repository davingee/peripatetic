class CreatePeripatheticCountries < ActiveRecord::Migration[8.0]
  def change
    create_table :peripatetic_countries do |t|
      t.string :name, null: false
      t.string :alpha2, null: false, limit: 2
      t.string :alpha3, limit: 3
      t.integer :iso_numeric_code
      t.string :region
      t.string :sub_region

      t.timestamps
    end

    add_index :peripatetic_countries, :alpha2, unique: true
    add_index :peripatetic_countries, :name, unique: true
  end
end

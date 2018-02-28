class AddIndexOnCountryCodeToCountries < ActiveRecord::Migration[5.1]
  def change
    add_index :countries, :country_code, unique: true
  end
end

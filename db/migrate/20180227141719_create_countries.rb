class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :country_code, limit: 2
      t.references :panel_provider, foreign_key: true
    end
  end
end

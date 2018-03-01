class CreateAccessTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :access_tokens do |t|
      t.references :panel_provider, foreign_key: true
      t.string :key, null: false
      t.timestamp :expiration_date
    end
    add_index :access_tokens, :key, unique: true
  end
end

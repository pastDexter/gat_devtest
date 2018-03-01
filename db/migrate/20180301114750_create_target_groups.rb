class CreateTargetGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :target_groups do |t|
      t.string :name
      t.string :external_id
      t.string :secret_code
      t.integer :parent, null: true, foreign_key: { to_table: :target_groups }
      t.references :panel_provider, foreign_key: true
    end
  end
end

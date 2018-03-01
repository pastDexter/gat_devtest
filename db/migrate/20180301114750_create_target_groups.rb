class CreateTargetGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :target_groups do |t|
      t.string :name
      t.string :external_id
      t.string :secret_code
      t.references :parent, foreign_key: true, null: false
      t.references :panel_provider, foreign_key: true
    end
  end
end

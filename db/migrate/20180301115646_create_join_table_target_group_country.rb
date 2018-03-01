class CreateJoinTableTargetGroupCountry < ActiveRecord::Migration[5.1]
  def change
    create_join_table :target_groups, :countries do |t|
      t.index [:target_group_id, :country_id], name: 'index_target_group_country_join_table'
      t.index [:country_id, :target_group_id], name: 'index_country_target_group_join_table'
    end
  end
end

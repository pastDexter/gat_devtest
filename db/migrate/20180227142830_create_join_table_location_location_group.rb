class CreateJoinTableLocationLocationGroup < ActiveRecord::Migration[5.1]
  def change
    create_join_table :locations, :location_groups do |t|
      t.index [:location_id, :location_group_id], name: 'index_locations_location_groups_join_table'
      t.index [:location_group_id, :location_id], name: 'index_location_groups_locations_join_table'
    end
  end
end

class CreateJoinTableUserPermission < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :permissions, table_name: 'user_permissions' do |t|
      t.index [:user_id, :permission_id]
    end
  end
end

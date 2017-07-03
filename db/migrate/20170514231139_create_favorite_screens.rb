class CreateFavoriteScreens < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_screens do |t|
      t.integer :screen_id
      t.integer :user_id

      t.timestamps
    end

    add_index :favorite_screens, [:user_id, :screen_id], unique: true
  end
end

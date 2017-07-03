class CreateDownloadedScreens < ActiveRecord::Migration[5.1]
  def change
    create_table :downloaded_screens do |t|
      t.integer :screen_id
      t.integer :user_id

      t.timestamps
    end

    add_index :downloaded_screens, [:user_id, :screen_id], unique: true
  end
end

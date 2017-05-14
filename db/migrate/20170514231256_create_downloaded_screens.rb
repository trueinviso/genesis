class CreateDownloadedScreens < ActiveRecord::Migration[5.1]
  def change
    create_table :downloaded_screens do |t|
      t.integer :screen_id
      t.integer :user_id

      t.timestamps
    end
  end
end

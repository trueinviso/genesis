class CreateScreens < ActiveRecord::Migration[5.1]
  def change
    create_table :screens do |t|
      t.string :amazon_s3_link
      t.string :image_link

      t.timestamps
    end
  end
end

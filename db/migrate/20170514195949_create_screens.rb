class CreateScreens < ActiveRecord::Migration[5.1]
  def change
    create_table :screens do |t|
      t.string :amazon_s3_link
      t.string :image_link
      t.integer :category_id

      t.timestamps
    end
  end
end

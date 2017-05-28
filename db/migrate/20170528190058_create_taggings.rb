class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.belongs_to :tag, foreign_key: true
      t.belongs_to :screen, foreign_key: true

      t.timestamps
    end
    #add_index :taggings, :tag_id
    #add_index :taggings, :screen_id
  end
end

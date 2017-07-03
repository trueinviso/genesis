class CreateSketchFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :sketch_files do |t|
      t.string :name
      t.text :file_data
      t.references :design, polymorphic: true, index:true
      t.timestamps
    end
  end
end

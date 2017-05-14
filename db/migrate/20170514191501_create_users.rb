class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :display_name
      t.string :username
      t.string :email, unique: true
      t.string :role
      t.boolean :signup_complete
      t.boolean :terms_and_conditions
      t.string :password
      t.string :password_confirmation
      t.string :password_digest
      t.string :stripe_id

      t.timestamps
    end
  end
end

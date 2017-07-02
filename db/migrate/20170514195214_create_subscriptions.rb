class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      t.string :stripe_payment_token
      t.string :stripe_plan_id
      t.string :card_exp_month
      t.string :card_exp_year
      t.string :card_last4
      t.string :card_brand
      t.datetime :ends_at

      t.timestamps
    end
  end
end

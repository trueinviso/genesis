class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      t.string :stripe_payment_token
      t.string :stripe_plan_id

      t.timestamps
    end
  end
end

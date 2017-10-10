FactoryGirl.define do
  factory :subscription do
    factory :monthly_subscription do
      sequence(:gateway_id) { "stripe_#{Rails.env}_#{rand(1..100)}" }
      # association :subscription_plan, factory: :btv_premium_monthly_plan
    end
  end
end

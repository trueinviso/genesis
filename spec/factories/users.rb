FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@genesis.com" }
    password "password"

    trait :with_monthly_subscription do
      after(:build) do |user|
        create(
          :subscription,
          stripe_subscription_id: "monthly_subscription",
          user: user,
        )
      end
    end
  end
end

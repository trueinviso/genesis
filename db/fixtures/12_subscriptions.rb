Subscription.seed_once(:user_id) do |s|
  s.id = 1
  s.user_id = 1
  s.stripe_plan_id = "monthly"
  s.card_exp_year = 2020
  s.card_exp_month = 5
  s.card_last4 = 4242
  s.card_brand = "Mastercard"
end

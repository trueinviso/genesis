require "rails_helper"

feature "User registration" do
  let(:stripe_helper) { StripeMock.create_test_helper }

  before do
    StripeMock.start
    mock_stripe_token
    stripe_helper.create_plan(id: "monthly", amount: 1500)
  end

  after { StripeMock.stop }

  context "Creating account" do
    scenario "user signup" do
      register_new_user
      expect(current_path).to eq root_path
    end
  end

  def register_new_user
    visit new_user_registration_path
    fill_in "user_first_name", with: "first"
    fill_in "user_last_name", with: "last"
    fill_in "user_email", with: "email@test.com"
    fill_in "user_password", with: "password"
    click_button "Continue"
    fill_in "card-number", with: "4111111111111111"
    fill_in "cvc", with: "123"
    click_button "Get started"
  end

  def mock_stripe_token
    token = stripe_helper.generate_card_token
    allow_any_instance_of(SubscriptionController)
      .to receive(:subscription_params)
      .and_return({ payment_token: token, plan: "monthly" })
  end
end

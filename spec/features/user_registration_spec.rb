require "rails_helper"

feature "User registration" do
  # include_context :shared_roles
  context "Creating account" do
    scenario "user signup" do
      register_new_user
      expect(current_path).to eq screens_path
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
end

require "rails_helper"

describe FavoriteScreen do
  describe "relationships" do
    it { is_expected.to belong_to(:user).touch(:true) }
    it { is_expected.to belong_to(:screen).touch(:true) }
  end

  describe "validations" do
    it do
      is_expected
        .to validate_uniqueness_of(:screen_id)
        .scoped_to(:user_id)
    end
  end
end

require "rails_helper"

describe Role do
  describe "relationships" do
    it do
      is_expected
        .to have_many(:users)
        .through(:user_roles)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end

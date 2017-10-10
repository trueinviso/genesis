require "rails_helper"

describe Permission do
  describe "relationships" do
    it do
      is_expected
        .to have_many(:users)
        .through(:user_permissions)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end

require "rails_helper"

describe UserRole do
  describe "relationships" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:role) }
  end
end

require "rails_helper"

describe UserPermission do
  describe "relationships" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:permission) }
  end
end

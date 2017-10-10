require "rails_helper"

describe Subscription do
  describe "relationships" do
    it { is_expected.to belong_to(:user) }
  end
end

require "rails_helper"

describe Tagging do
  describe "relationships" do
    it { is_expected.to belong_to(:tag) }
    it { is_expected.to belong_to(:screen) }
  end
end

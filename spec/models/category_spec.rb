require "rails_helper"

describe Category do
  describe "relationships" do
    it { is_expected.to have_many(:screens) }
  end
end

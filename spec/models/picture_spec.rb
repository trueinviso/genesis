require "rails_helper"

describe Picture do
  describe "relationships" do
    it { is_expected.to belong_to(:imageable) }
  end
end

require "rails_helper"

describe SketchFile do
  describe "relationships" do
    it { is_expected.to belong_to(:design) }
  end
end

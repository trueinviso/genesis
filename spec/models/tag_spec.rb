require "rails_helper"

describe Tag do
  describe "relationships" do
    it do
      is_expected
        .to have_many(:screens)
        .through(:taggings)
    end
  end
end

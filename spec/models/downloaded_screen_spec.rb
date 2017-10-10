require "rails_helper"

describe DownloadedScreen do
  describe "relationships" do
    it { is_expected.to belong_to(:user).touch(:true) }
    it { is_expected.to belong_to(:screen).touch(:true) }
  end
end

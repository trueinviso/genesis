require "rails_helper"

describe Screen do
  describe "relationships" do
    it do
      is_expected
        .to have_many(:favorited_by)
        .through(:favorite_screens)
        .source(:user)
    end

    it do
      is_expected
        .to have_many(:downloaded_by)
        .through(:downloaded_screens)
        .source(:user)
    end

    it { is_expected.to have_one(:picture).dependent(:destroy) }
    it { is_expected.to have_one(:sketch_file).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:category) }
  end
end

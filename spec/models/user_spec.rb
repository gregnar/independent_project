require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { FactoryGirl.build(:user) }
  let(:followee) { FactoryGirl.build(:followee) }
  let(:book) { FactoryGirl.build_stubbed(:book) }
  let(:rating1) { FactoryGirl.build(:rating1) }

  before(:each) do
    user.followees << followee
    followee.ratings << rating1
    user.save!(validate: false)
    followee.save!(validate: false)
  end

  context "when not making api calls" do
    it "can set an access token" do
      return_value = user.set_access_token("123", "abc")
      expect(return_value).to be_an_instance_of AccessToken
    end

    it "can generate a custom rating" do
      expect(user.custom_rating(rating1.book_id)).to eq(5.0)
    end

    it "can handle a book without a custom rating" do
      expect(user.custom_rating(000)).to eq("None yet!")
    end
  end

  context "when making api calls" do

    
  end

end

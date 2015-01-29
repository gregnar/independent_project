require 'rails_helper'

RSpec.describe User, :type => :model do

  context "when not making api calls" do
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

    it "can set an access token" do
      return_value = user.set_access_token("123", "abc")
      expect(return_value).to be_an_instance_of AccessToken
    end

    it "can generate a custom rating" do
      rating = user.custom_rating(rating1.book_id)
      expect(rating).to eq(5.0)
    end

    it "can handle a book without a custom rating" do
      expect(user.custom_rating(000)).to eq("None yet!")
    end
  end

  context "when making api calls" do
    let(:user) { User.create(goodreads_id: 9186805) }

    before(:each) do
      user.access_token = AccessToken.create(token: "1iGjnyBKj8gUvBuACNtw", secret: "69jHAAwP4evm2U4uIKvzsuCAzLFqGof88V8ZsUo1As", user_id: user.id)
    end

    it "can update followees" do
      VCR.use_cassette('update_followees') do
        expect(user.followees.count).to eq 0
        user.update_followees
        expect(user.followees.count).to_not eq 0
      end
    end

    it "can update ratings and books" do
      VCR.use_cassette('update_ratings') do
        expect(user.ratings.count).to eq 0
        expect(user.books.count).to eq 0
        user.update_followees
        user.update_ratings_and_books
        expect(user.ratings.count).to_not eq 0
        expect(user.books.count).to_not eq 0
      end
    end

    it "can update suggested followees" do
      VCR.use_cassette('update_suggested_followees') do
        expect(user.suggested_followees.count).to eq 0
        user.update_followees
        user.update_suggested_followees
        expect(user.suggested_followees.count).to_not eq 0
      end
    end

    it "can compare books with a user" do
      VCR.use_cassette('compare_books') do
        user.update_followees
        comparison = user.compare(user.followees.first.goodreads_id)
        expect(comparison.first.keys).to include("their_review")
        expect(comparison.first.keys).to include("your_review")
      end
    end\

    it "tries to follow a user" do
      VCR.use_cassette('follow') do
        response = user.follow(4384303)
        expect(response.code).to eq "422"
        expect(response.body).to include("You're already following this user.")
      end
    end

    it "can add a book to the to-read shelf" do
      VCR.use_cassette('user_add_book') do
        response = user.add_book(1)
        expect(response.code).to eq("201")
      end
    end
  end
end

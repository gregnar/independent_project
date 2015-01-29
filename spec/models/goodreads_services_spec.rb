require 'rails_helper'

RSpec.describe GoodreadsServices, :type => :model do


  let(:user) { User.create(goodreads_id: 9186805) }

  before(:each) do
    user.access_token = AccessToken.create(token: "1iGjnyBKj8gUvBuACNtw", secret: "69jHAAwP4evm2U4uIKvzsuCAzLFqGof88V8ZsUo1As", user_id: user.id)
  end

  it "can get a user's followees" do
    VCR.use_cassette('raw_followees') do
      followees = user.goodreads_services.get_user_followees
      expect(followees).to be_an_instance_of String
      expect(followees).to include("Bethany")
    end
  end

  it "can get all reviews for a user" do
    VCR.use_cassette('reviews') do
      reviews = user.goodreads_services.get_ratings_and_books_for_single_user(user.goodreads_id)
      expect(reviews).to be_an_instance_of String
      expect(reviews).to include("reviews")
    end
  end

  it "can compare reviews with another user" do
    VCR.use_cassette('comparison') do
      comparison = user.goodreads_services.get_comparison(4384303)
      expect(comparison).to be_an_instance_of String
      expect(comparison).to include("their_review")
      expect(comparison).to include("your_review")
    end
  end

  it "makes the correct request for adding a book" do
    VCR.use_cassette('add_book') do
      response = user.goodreads_services.add_book(12872236)
      expect(response.code).to eq "201"
    end
  end

  it "tries to follow a user" do
    VCR.use_cassette('follow') do
      response = user.goodreads_services.follow(4384303)
      expect(response.code).to eq "422"
      expect(response.body).to include("You're already following this user.")
    end
  end

  it "can search for books" do
    VCR.use_cassette('search_books') do
      response = GoodreadsServices.search_books("Great Expectations")
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.results.work.first.best_book.author.name).to eq("Charles Dickens")
    end
  end

end

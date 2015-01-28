require 'rails_helper'
RSpec.describe BookSearchResultsManager, :type => :model do

  let(:search_results) do
    Goodreads.new.search_books('Great Expectations').results.work
  end

  it "receives a ruby object and returns a cleaned ruby object" do
    VCR.use_cassette('search_results') do
      expect(search_results.first).to be_an_instance_of(Hashie::Mash)
      expect(search_results.first.keys).to_not include("goodreads_rating")
      cleaned_info = BookSearchResultsManager.sanitize_books(search_results)
      expect(cleaned_info.first.keys).to include("goodreads_rating")
    end
  end
end

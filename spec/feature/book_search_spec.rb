require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'book search', type: :feature do

  context "as an authenticated user" do

    before(:each) do
      log_in
    end

    it "can search for a book and get results" do
      VCR.use_cassette('search_books_feature') do
        fill_in 'search books', with: 'Great Expectations'
        click_button 'Search'
        expect(current_path).to eq book_search_results_path
        expect(page).to have_content("Great Expectations")
      end
    end

    it "doesn't blow up when no results are returned" do
      VCR.use_cassette('no_search_results_feature') do
        fill_in 'search books', with: 'aoisdhfgoiashgio'
        click_button 'Search'
        expect(current_path).to eq book_search_results_path
      end
    end

  end

end

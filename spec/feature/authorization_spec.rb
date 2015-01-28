require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'OmniAuth authorization', type: :feature do

  context "when an unauthenticated user" do

    it "can log in with goodreads and redirect to dashboard" do
      log_in
      expect(current_path).to eq(dashboard_index_path)
    end

    it "can visit the root path without being redirected" do
      visit root_path
      expect(current_path).to eq(root_path)
    end

  end

  context "when an authenticated user" do

    before(:each) do
      log_in
    end

    it "can log out" do
      click_link 'logout'
      expect(current_path).to_not have_content("logout")
    end

    it 'cannot visit the dashboard after logging out' do
      click_link 'logout'
      visit dashboard_index_path
      expect(current_path).to eq(root_path)
    end

    it "cannot visit root path without being redirected" do
      visit root_path
      expect(current_path).to eq(dashboard_index_path)
    end

  end

end

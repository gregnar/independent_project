require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'OmniAuth authorization', type: :feature do

  context "when an unauthenticated user" do

    it "can log in with goodreads and redirect to dashboard" do
      log_in
      expect(current_path).to eq(dashboard_index_path)
    end

  end

  context "when an authenticated user" do

    it "can log out" do
      log_in
      click_link 'logout'
    end

    it 'cannot visit the dashboard' do
      log_in
      click_link 'logout'
      visit dashboard_index_path
      expect(current_path).to eq(root_path)
    end
  end

end

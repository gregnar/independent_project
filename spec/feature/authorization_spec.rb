require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'OmniAuth authorization', type: :feature do

  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:goodreads] = nil
    OmniAuth.config.mock_auth[:goodreads] = OmniAuth::AuthHash.new({
      :provider => 'goodreads',
      :uid => '123445'
    })
    # request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:goodreads]
  end

  context "when an unauthenticated user" do

    xit "can log in with goodreads" do
      visit root_path
      click_link "login"
    end


  end

end

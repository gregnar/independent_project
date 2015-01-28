require 'rails_helper'

describe 'adding a book to shelf', type: :feature do

  context "as an authenticated user" do

    xit "can add a book to the to-read shelf" do
      log_in
      books = [Book.all.sample]
      DashboardController.stub!( :@books ).with(books).and_return( books )
      visit dashboard_index_path
      save_and_open_page
    end

  end
end

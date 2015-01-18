class DashboardController < ApplicationController
  def index
    #get rid of this eventually
    @book = basic_goodreads_client.book("9364729")
  end
end

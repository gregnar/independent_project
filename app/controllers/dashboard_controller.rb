class DashboardController < ApplicationController
  before_action :require_current_user
  
  def index
    #get rid of this eventually
    @book = basic_goodreads_client.book("9364729")
  end
end

class DashboardController < ApplicationController
  before_action :require_current_user

  def index
    @books = current_user.books.take(6)
  end
end

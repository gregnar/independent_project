class DashboardController < ApplicationController
  before_action :require_current_user

  def index
    @books               = current_user.books.take(3)
    @followees           = current_user.followees.take(4)
    @suggested_followees = current_user.suggested_followees.sort_by(&:goodreads_id).take(4)
  end

end

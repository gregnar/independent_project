class UserFolloweesController < ApplicationController

  def create
    current_user.follow(params[:followee_id])
    redirect_to dashboard_index_path
  end

end

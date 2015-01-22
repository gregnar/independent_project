class UserFolloweesController < ApplicationController
  def create
    current_user.follow(params[:followee_id])
  end
end

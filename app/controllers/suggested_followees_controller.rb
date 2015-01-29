class UserFolloweesController < ApplicationController

  def index
    @suggested_followees = current_user.suggested_followees
  end

end

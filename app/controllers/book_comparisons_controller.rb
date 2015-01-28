class BookComparisonsController < ApplicationController

  def show
    @suggested_followee = SuggestedFollowee.find_by(goodreads_id: params[:id])
    @comparisons        = current_user.compare(params[:id])
  end

end

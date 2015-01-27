class BookComparisonsController < ApplicationController

  def show
    @suggested_followee = SuggestedFollowee.find_by(goodreads_id: params[:id])
    @comparisons = comparison_object
  end

  private

  def comparison_object
    comparisons = current_user.compare(params[:id])
    Array.new << comparisons if comparisons.is_a?(Hash)
    comparisons
  end

end

class BookComparisonsController < ApplicationController

  def show
    @compared_user      = compared_user
    @comparisons        = current_user.compare(params[:id])
    @similarity_score   = get_similarity(@comparisons) unless @comparisons.empty?
  end

  private

  def get_similarity(comparisons)
    SimilarityCalculator.new(comparisons).calculate_similarity
  end

  def compared_user
    SuggestedFollowee.find_by(goodreads_id: params[:id]) || Followee.find_by(goodreads_id: params[:id])
  end

end

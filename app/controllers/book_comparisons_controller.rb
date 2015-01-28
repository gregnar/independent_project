class BookComparisonsController < ApplicationController

  def show
    @suggested_followee = SuggestedFollowee.find_by(goodreads_id: params[:id])
    @comparisons        = current_user.compare(params[:id])
    @similarity_score   = get_similarity(@comparisons) unless @comparisons.empty?
  end

  private

  def get_similarity(comparisons)
    SimilarityCalculator.new(comparisons).calculate_similarity
  end

end

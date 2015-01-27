class SuggestedFolloweesManager

  def initialize(user, followee, suggestions)
    @user        = user
    @followee    = followee
    @suggestions = suggestions
  end

  def update_suggested_followees
    suggestions.each do |suggestion_hash|
      create_suggested_followee(suggestion_hash) unless ineligible?(suggestion_hash)
    end
  end

  private

  def user
    @user
  end

  def followee
    @followee
  end

  def suggestions
    @suggestions
  end

  def ineligible?(hash)
    existing_suggested_followee?(hash) || existing_followee?(hash)
  end

  def existing_suggested_followee?(suggestion_hash)
    user.suggested_followees.find_by(goodreads_id: suggestion_hash['id'])
  end

  def existing_followee?(suggestion_hash)
    user.followees.find_by(goodreads_id: suggestion_hash['id'])
  end

  def create_suggested_followee(suggestion_hash)
    attributes = suggested_followee_attributes(suggestion_hash)
    user.suggested_followees.create!(attributes)
  end

  def suggested_followee_attributes(suggestion_hash)
    suggestion_hash.slice('id', 'name', 'link', 'image_url', 'small_image_url')
                   .tap do |h|
                     h['goodreads_id'] = h['id']; h.delete('id')
                     h['followee_id']  = followee.id
                   end
  end

end

class RatingsManager

  def self.update_ratings_for_user(ratings)
    cleaned_ratings = clean_ratings_up(ratings)
    cleaned_ratings.each { |rating| Rating.create(rating) }
  end

  def self.clean_ratings_up(ratings)
    ratings.reject { |rating| rating['id'] == 0 }
           .map    { |rating| select_needed_keys(rating) }
  end

  def self.select_needed_keys(rating_hash)
    rating_hash.slice('followee_id', 'book' 'rating')
               .tap { |h| h['book_id'] = h['book']['id']; h.delete['book'] }
  end
end

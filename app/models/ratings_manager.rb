class RatingsManager

  def self.update_ratings(ratings)
    cleaned_ratings = clean_ratings_up(ratings)
    cleaned_ratings.each do |r|
      existing_rating(r) ? existing_rating(r).update_attributes(r) : Rating.create(r)
    end
  end

  def existing_rating(rating)
    Rating.find_by(followee_id: rating['followee_id'], book_id: rating['book_id'])
  end

  def self.clean_ratings_up(ratings)
    ratings.reject { |rating| rating['id'] == '0' }
           .map    { |rating| select_needed_keys(rating) }
  end

  def self.select_needed_keys(rating_hash)
    rating_hash.slice('followee_id', 'book' 'rating')
               .tap { |h| h['book_id'] = h['book']['id']; h.delete['book'] }
  end
end

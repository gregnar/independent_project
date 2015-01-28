class RatingsManager

  def self.create(rating)
    Rating.create(rating) unless existing_rating(rating)
  end

  def self.existing_rating(rating)
    Rating.find_by(followee_id: rating['followee_id'], book_id: rating['book_id'])
  end

end

class RatingsGenerator

  def self.generate_rating(user, book_id)
    ratings = all_ratings(user, book_id)
    return "None of your followers have rated this book!" if ratings == []
    ratings.inject(&:+).to_f / ratings.size
  end

  def self.all_ratings(user, book_id)
    user.followees.inject([]) do |array, followee|
      followee_rating = followee.ratings.find_by(book_id: book_id)
      array << followee_rating.rating if followee_rating
      array
    end
  end

end

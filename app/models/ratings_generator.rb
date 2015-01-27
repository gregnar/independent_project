class RatingsGenerator

  def self.generate_rating(user, book_id)
    ratings = all_ratings(user, book_id)
    return "None yet!" if ratings.empty?
    ratings.inject(&:+).fdiv(ratings.size).round(2)
  end

  def self.all_ratings(user, book_id)
    user.followees.inject([]) do |array, followee|
      followee_rating = followee.ratings.find_by(book_id: book_id)
      array.tap { |a| a << followee_rating.rating if followee_rating }
    end
  end

end

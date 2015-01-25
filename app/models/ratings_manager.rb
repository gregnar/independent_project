class RatingsManager

  # def initialize(user, ratings)
  #   @user    = user
  #   @ratings = ratings
  # end

  def self.update_ratings(ratings)
    clean_ratings_up(ratings)
  end

  def clean_ratings_up(ratings)
    ratings.reject { |rating| rating['id'] == 0 }
  end
end

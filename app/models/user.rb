class User < ActiveRecord::Base
  validates :goodreads_id, presence: true, uniqueness: true
  has_one :access_token, dependent: :destroy
  has_many :followees
  has_many :ratings, through: :followees
  has_many :suggested_followees, dependent: :destroy
  has_many :books, through: :ratings

  def set_access_token(token, secret)
    access_token.destroy if access_token.present?
    access_token = AccessToken.create(token: token, secret: secret, user_id: id)
  end

  def follow(user_id)
    goodreads_services.follow(user_id)
  end

  def custom_rating(book_id)
    RatingsGenerator.generate_rating(self, book_id)
  end

  def update_followees
    goodreads_services.update_followees
  end

  def update_ratings_and_books
    goodreads_services.update_ratings_and_books
  end

  def custom_rating(book_id)
    RatingsGenerator.generate_rating(self, book_id)
  end

  def add_book(book_id)
    goodreads_services.add_book(book_id)
  end

  def compare(goodreads_id)
    goodreads_services.compare(goodreads_id)
  end

  def update_suggested_followees
    goodreads_services.update_suggested_followees
  end

  def goodreads_services
    @goodreads_services ||= GoodreadsServices.new(self)
  end


end

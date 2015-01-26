class User < ActiveRecord::Base
  validates :goodreads_id, presence: true, uniqueness: true
  has_one :access_token, dependent: :destroy
  has_many :followees
  has_many :ratings, through: :followees

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

  def friends
    goodreads_services.all_friends
  end

  def update_followees
    goodreads_services.update_followees
  end

  def update_ratings
    goodreads_services.update_ratings
  end

  def update_books
    goodreads_services.update_books
  end

  def custom_rating(book_id)
    RatingsGenerator.generate_rating(self, book_id)
  end

  def ids_for_rated_books
    ratings.pluck(:book_id).uniq
  end

  def rated_books

  end

  def book_ids
    ratings.pluck(:book_id).uniq
  end

  def uncached_book_ids
    book_ids.delete_if { |id| Book.find_by(goodreads_id: id) }
  end


  private

  def goodreads_services
    @goodreads_services ||= GoodreadsServices.new(self)
  end


end

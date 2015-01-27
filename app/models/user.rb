class User < ActiveRecord::Base
  validates :goodreads_id, presence: true, uniqueness: true
  has_one :access_token, dependent: :destroy
  has_many :followees
  has_many :ratings, through: :followees
  has_many :suggested_followees

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

  def book_ids
    ratings.pluck(:book_id).uniq
  end

  def uncached_book_ids
    book_ids.delete_if { |id| Book.find_by(goodreads_id: id) }
  end

  def books
    book_ids.inject([]) { |ary, id| ary << Book.find_by(goodreads_id: id); ary }
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

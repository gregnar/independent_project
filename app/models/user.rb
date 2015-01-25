class User < ActiveRecord::Base
  validates :goodreads_id, presence: true, uniqueness: true
  has_one :access_token, dependent: :destroy
  has_many :followees

  def set_access_token(token, secret)
    access_token.destroy if access_token.present?
    access_token = AccessToken.create(token: token, secret: secret, user_id: id)
  end

  def follow(user_id)
    goodreads_services.follow(user_id)
  end

  def custom_rating(id, book_id)
    goodreads_services.custom_rating(book_id)
  end

  def friends
    goodreads_services.all_friends
  end

  def update_followees
    goodreads_services.update_followees
  end

  def update_followee_ratings
    RatingsManager.collect_ratings(followees)
  end


  def custom_rating(book_id)
    RatingsGenerator.generate_rating(user_id, book_id)
  end


  private

  def goodreads_services
    @goodreads_services ||= GoodreadsServices.new(self)
  end

end

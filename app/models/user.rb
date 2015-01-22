class User < ActiveRecord::Base
  validates :goodreads_id, presence: true, uniqueness: true
  has_one :access_token, dependent: :destroy

  def set_access_token(token, secret)
    access_token.destroy if access_token.present?
    access_token = AccessToken.create(token: token, secret: secret, user_id: id)
  end

  def follow(user_id)
    goodreads_services.follow(user_id)
  end

  # def followees
  #   goodreads_services.followees(goodreads_id)
  # end

  private

  def goodreads_services
    @goodreads_services ||= GoodreadsServices.new(access_token.token, access_token.secret)
  end

end

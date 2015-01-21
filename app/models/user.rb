class User < ActiveRecord::Base
  validates :goodreads_id, presence: true, uniqueness: true
  has_one :access_token, dependent: :destroy

  def set_access_token(token, secret)
    access_token = AccessToken.create(token: token, secret: secret)
  end

end

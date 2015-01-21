class User < ActiveRecord::Base
  validates :goodreads_id, presence: true, uniqueness: true
  has_one :access_token, dependent: :destroy



  
  def set_access_token(token, secret)
    access_token.destroy if access_token.present?
    access_token = AccessToken.create(token: token, secret: secret, user_id: id)
  end

end

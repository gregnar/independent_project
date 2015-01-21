class AccessToken < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true
  validates :secret, presence: true
  validates :user_id, uniqueness: true
end

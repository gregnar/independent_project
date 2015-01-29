class Followee < ActiveRecord::Base
  belongs_to :user
  has_many :ratings, dependent: :destroy
  validates_presence_of :goodreads_id,
                        :name,
                        :user_id,
                        :link,
                        :small_image_url,
                        :image_url

  has_many :suggested_followees

end

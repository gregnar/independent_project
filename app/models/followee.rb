class Followee < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :goodreads_id,
                        :name,
                        :user_id,
                        :link,
                        :small_image_url,
                        :image_url

end

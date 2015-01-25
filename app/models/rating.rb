class Rating < ActiveRecord::Base
  belongs_to :followee

  validates_presence_of :book_id, :followee_id, :rating
end

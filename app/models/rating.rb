class Rating < ActiveRecord::Base
  belongs_to :followee
  belongs_to :book

  validates_presence_of :book_id, :followee_id, :rating
end

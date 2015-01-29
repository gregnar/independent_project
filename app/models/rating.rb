class Rating < ActiveRecord::Base
  belongs_to :followee
  belongs_to :book, :foreign_key => 'book_id', :primary_key => 'goodreads_id'

  validates_presence_of :book_id, :followee_id, :rating
end

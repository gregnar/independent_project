class Book < ActiveRecord::Base
  validates :goodreads_id, uniqueness: true
end

class AddGoodreadsRatingToBooks < ActiveRecord::Migration
  def change
    add_column :books, :goodreads_rating, :string
  end
end

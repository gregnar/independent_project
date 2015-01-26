class AddColumnsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :goodreads_id, :integer
    add_column :books, :small_image_url, :string
    add_column :books, :image_url, :string
    add_column :books, :name, :string
    add_column :books, :author, :string
  end
end

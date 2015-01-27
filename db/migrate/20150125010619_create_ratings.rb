class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :book_id
      t.references :followee, index: true
      t.integer :rating

      t.timestamps null: false
    end
    add_foreign_key :ratings, :followees
  end
end

class CreateFollowees < ActiveRecord::Migration
  def change
    create_table :followees do |t|
      t.integer :goodreads_id
      t.string :name
      t.string :link
      t.string :image_url
      t.string :small_image_url
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :followees, :users
  end
end

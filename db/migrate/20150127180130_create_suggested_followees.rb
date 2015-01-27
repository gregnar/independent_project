class CreateSuggestedFollowees < ActiveRecord::Migration
  def change
    create_table :suggested_followees do |t|
      t.integer :goodreads_id
      t.references :followee, index: true
      t.references :user, index: true
      t.string :name
      t.string :image_url
      t.string :small_image_url

      t.timestamps null: false
    end
    add_foreign_key :suggested_followees, :followees
    add_foreign_key :suggested_followees, :users
  end
end

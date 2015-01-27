class AddLinkToSuggestedFollowees < ActiveRecord::Migration
  def change
    add_column :suggested_followees, :link, :string
  end
end

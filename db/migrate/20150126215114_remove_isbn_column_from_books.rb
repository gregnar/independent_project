class RemoveIsbnColumnFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :isbn, :integer
  end
end

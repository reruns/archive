class AddsNestingToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_comment_id, :integer, default: nil
    add_index :comments, :parent_comment_id
  end


end

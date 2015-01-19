class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.references :commentable, polymorphic: true
      t.timestamps
    end

    add_index :comments, :commentable_id
  end
end

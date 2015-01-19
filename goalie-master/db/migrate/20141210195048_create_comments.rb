class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment, null: false
      t.integer :author_id, null: false
      t.references :commentable, polymorphic: true

      t.timestamps
    end

    add_index :comments, :author_id
  end
end

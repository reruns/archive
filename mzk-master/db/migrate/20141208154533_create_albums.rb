class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :name, null: false
      t.string :kind

      t.timestamps
    end
    add_index :albums, :band_id
  end
end

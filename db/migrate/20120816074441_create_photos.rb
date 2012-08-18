class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :thumbnail_url
      t.string :medium_url
      t.string :large_url
      t.string :caption
      t.integer :user_id
      t.boolean :profile_pic

      t.timestamps
    end
  end
end

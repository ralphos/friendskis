class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :gender
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :username
      t.date :date_of_birth
      t.text :bio
      t.string :preference
      t.integer :min_age
      t.integer :max_age
      t.string :location

      t.timestamps
    end
  end
end

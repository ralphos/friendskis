class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.string :fb_uid
      t.string :fb_request_id
      t.string :concat_request_field
      t.boolean :accepted_invite

      t.timestamps
    end
  end
end

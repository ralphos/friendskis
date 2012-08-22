class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.text :body
      t.integer :recipients_id
      t.string :recipients_username

      t.timestamps
    end
  end
end

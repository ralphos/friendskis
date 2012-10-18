class AddColumnsToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :sender_unlocked, :boolean, default: false
    add_column :conversations, :recipient_unlocked, :boolean, default: false
  end
end

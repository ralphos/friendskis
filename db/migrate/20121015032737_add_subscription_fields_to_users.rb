class AddSubscriptionFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscription_id, :string
    add_column :users, :subscription_status, :string
    add_column :users, :subscription_error_code, :integer
    add_column :users, :subscription_error_message, :string
  end
end

class AddFirstLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_first_login, :boolean, default: true
  end
end

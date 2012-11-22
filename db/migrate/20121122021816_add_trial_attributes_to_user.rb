class AddTrialAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :trial_start_at, :datetime
    add_column :users, :trial_end_at, :datetime
  end
end

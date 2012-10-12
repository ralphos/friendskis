class AddPercentScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :percent_score, :integer, default: 0
  end
end

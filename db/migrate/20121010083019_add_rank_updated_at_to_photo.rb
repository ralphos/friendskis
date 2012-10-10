class AddRankUpdatedAtToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :rank_updated_at, :datetime, default: DateTime.now
  end
end

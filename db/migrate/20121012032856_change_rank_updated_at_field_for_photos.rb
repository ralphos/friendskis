class ChangeRankUpdatedAtFieldForPhotos < ActiveRecord::Migration
  def up
    change_column :photos, :rank_updated_at, :datetime, default: nil
  end
end

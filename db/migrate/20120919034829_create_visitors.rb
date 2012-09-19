class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :user_id
      t.string :visitor_id

      t.timestamps
    end
  end
end

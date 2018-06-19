class CreateBuddies < ActiveRecord::Migration[5.1]
  def change
    create_table :buddies do |t|
      t.integer :owner_profile_id, null: false
      t.integer :buddy_profile_id, null: false

      t.boolean :is_blacklisted, default: false

      t.timestamps
    end
  end
end

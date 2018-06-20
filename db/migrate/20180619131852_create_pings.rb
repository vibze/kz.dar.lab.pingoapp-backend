class CreatePings < ActiveRecord::Migration[5.1]
  def change
    create_table :pings do |t|
      t.integer :profile_id, null: false
      t.integer :device_id, null: false
      t.string :text, null: false
      t.timestamps
    end
  end
end

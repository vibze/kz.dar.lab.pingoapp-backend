class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.integer :profile_id, null: false
      t.string :provider, null: false
      t.string :push_token, null: false
      t.timestamps
    end
  end
end

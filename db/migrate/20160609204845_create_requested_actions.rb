class CreateRequestedActions < ActiveRecord::Migration
  def change
    create_table :requested_actions do |t|
      t.string :device_id
      t.string :requested_service

      t.timestamps null: false
    end
  end
end

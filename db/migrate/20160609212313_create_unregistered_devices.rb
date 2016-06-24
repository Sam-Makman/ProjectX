class CreateUnregisteredDevices < ActiveRecord::Migration
  def change
    create_table :unregistered_devices do |t|
      t.timestamps null: false
    end
  end
end

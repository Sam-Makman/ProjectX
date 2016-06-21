class AddIndexToDeviceId < ActiveRecord::Migration
  def change
    add_index :unregistered_devices, :device_id, :unique => true
  end
end

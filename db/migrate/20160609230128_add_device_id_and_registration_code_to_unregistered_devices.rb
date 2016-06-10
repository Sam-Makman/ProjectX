class AddDeviceIdAndRegistrationCodeToUnregisteredDevices < ActiveRecord::Migration
  def change
    add_column :unregistered_devices, :device_id, :string
    add_column :unregistered_devices, :unique_id, :string
  end
end

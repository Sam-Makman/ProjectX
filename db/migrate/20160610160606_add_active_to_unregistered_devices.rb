class AddActiveToUnregisteredDevices < ActiveRecord::Migration
  def change
    add_column :unregistered_devices, :active, :boolean, default: false
  end
end

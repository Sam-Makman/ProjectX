class AddNotNullToActive < ActiveRecord::Migration
  def change
    change_column :unregistered_devices, :active, :boolean, :default => false, :null => false
  end
end

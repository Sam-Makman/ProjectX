class AddExpirationTimeToOauth < ActiveRecord::Migration
  def change
          add_column :oauths, :expiration_time, :timestamp
  end
end

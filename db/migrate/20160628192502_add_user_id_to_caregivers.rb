class AddUserIdToCaregivers < ActiveRecord::Migration
  def change
    add_reference :caregivers, :users, index: true
  end
end

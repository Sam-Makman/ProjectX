class AddColumnsToUser < ActiveRecord::Migration
  def change
      add_column :users, :first_name, :string
      add_column :users, :last_name, :string
      add_column :users, :home_phone, :string
      add_column :users, :cell_phone, :string
  end
end

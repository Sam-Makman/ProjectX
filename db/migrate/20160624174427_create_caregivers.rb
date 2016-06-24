class CreateCaregivers < ActiveRecord::Migration
  def change
    create_table :caregivers do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number

      t.timestamps null: false
    end
  end
end

class CreateOauths < ActiveRecord::Migration
  def change
    create_table :oauths do |t|
      t.string :name
      t.string :token

      t.timestamps null: false
    end
  end
end

# CreateAdopters is migration to create a schema for adopters
class CreateAdopters < ActiveRecord::Migration[5.2]
  def change
    create_table :adopters do |t|
      t.string :fname
      t.string :lname
      t.string :address
      t.integer :phone
      t.string :email
      t.timestamp :time

      t.timestamps
    end
  end
end

# AddAdoptTimeToProducts is a migration to add adopt time column to Products table
class AddAdoptTimeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :adopt_time, :timestamp
  end
end

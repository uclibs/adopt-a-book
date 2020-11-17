# RemoveTimeFromAdopters is a migration to remove time column from Adopters table
class RemoveTimeFromAdopters < ActiveRecord::Migration[5.2]
  def change
    remove_column :adopters, :time, :timestamp
  end
end

# ChangeDataTypeForPhone is a migration to change datatype of phone field from integer to text
class ChangeDataTypeForPhone < ActiveRecord::Migration[5.2]
  def change
    change_column :adopters, :phone, :text, limit: 12
  end
end

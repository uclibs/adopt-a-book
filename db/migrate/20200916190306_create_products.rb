# CreateProducts is migration to create a schema for products
class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string(:title)
      t.string(:author)
      t.string(:pub_year)
      t.string(:category)
      t.string(:image)
      t.string(:library)
      t.string(:description)
      t.string(:condition_treatment)
      t.integer(:adopt_status, limit: 1, default: 0)
      t.decimal(:adopt_amount)
      t.integer(:release_year, limit: 4)
      t.string(:dedication, limit: 75)
      t.string(:recognition)
      t.string(:adopter_fname)
      t.string(:adopter_lname)
      t.string(:adopter_address)
      t.integer(:adopter_phone, limit: 10)
      t.string(:adopter_email)
      t.timestamp(:adopt_time)

      t.timestamps
    end
  end
end

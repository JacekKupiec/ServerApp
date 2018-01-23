class AddBrandToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :brand, :string
  end
end

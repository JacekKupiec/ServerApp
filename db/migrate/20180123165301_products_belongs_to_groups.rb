class ProductsBelongsToGroups < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :group
  end
end

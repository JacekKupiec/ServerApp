class AddGuidToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :guid, :string
  end
end

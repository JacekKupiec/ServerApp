class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :store_name
      t.decimal :price, precision: 10, scale: 2, default: 0
      t.integer :amount, default: 0
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end

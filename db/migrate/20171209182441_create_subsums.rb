class CreateSubsums < ActiveRecord::Migration[5.1]
  def change
    create_table :subsums do |t|
      t.integer :subtotal
      t.belongs_to :product, index: true
      t.belongs_to :token, index: true

      t.timestamps
    end
  end
end

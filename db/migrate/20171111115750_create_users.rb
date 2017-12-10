class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_hash
      t.string :token
      t.datetime :token_expiration_date
      t.string :refresh_token
      t.datetime :refresh_token_expiration_date
      t.timestamps
    end
  end
end

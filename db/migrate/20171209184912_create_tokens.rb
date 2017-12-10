class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :token
      t.datetime :token_expiration_date
      t.string :refresh_token
      t.datetime :refresh_token_expiration_date
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end

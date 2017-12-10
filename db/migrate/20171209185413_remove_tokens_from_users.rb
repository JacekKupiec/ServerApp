class RemoveTokensFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :token, :string
    remove_column :users, :token_expiration_date, :daetime
    remove_column :users, :refresh_token, :string
    remove_column :users, :refresh_token_expiration_date, :datetime
  end
end

class AddReferenceFromGroupsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :groups, :user
  end
end

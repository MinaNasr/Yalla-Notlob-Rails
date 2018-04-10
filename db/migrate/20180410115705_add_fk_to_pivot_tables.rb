class AddFkToPivotTables < ActiveRecord::Migration[5.1]
  def change
    add_index :friends, [:friend_id, :user_id], unique: true
    add_index :group_details, [:group_id, :user_id], unique: true
    add_index :order_users, [:order_id, :user_id], unique: true    

  end
end

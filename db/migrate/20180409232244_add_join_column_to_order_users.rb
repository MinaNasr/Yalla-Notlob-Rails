class AddJoinColumnToOrderUsers < ActiveRecord::Migration[5.1]
  
  def change
    add_column :order_users, :join, :boolean, default: false
  end
end

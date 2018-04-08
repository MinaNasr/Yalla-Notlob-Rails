class ChangeOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :meal_name,:string, null:false
    add_column :orders, :restaurant_name,:string, null:false
  end
end

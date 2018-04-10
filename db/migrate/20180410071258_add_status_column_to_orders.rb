class AddStatusColumnToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :status, :string , default: "w"
  end
end

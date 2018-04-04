class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.string :comment
      t.string :item_name, null:false
      t.integer :amount, default:1
      t.integer :price, null:false

      t.timestamps
    end
  end
end

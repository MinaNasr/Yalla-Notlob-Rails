class CreateOrderUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :order_users do |t|
      t.references :user
      t.references :order 

      t.timestamps
    end
  end
end

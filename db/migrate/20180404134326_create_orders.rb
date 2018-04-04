class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :meal_name, nll:false
      t.string :image

      t.timestamps
    end
  end
end

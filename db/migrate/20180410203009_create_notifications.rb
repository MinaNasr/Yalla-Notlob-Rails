class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user
      t.string :type
      t.boolean :order_finished, default: false
      t.references :order
      t.string :user_name
      t.boolean :viewed, default: false

      t.timestamps
    end
  end
end

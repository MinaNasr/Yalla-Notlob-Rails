class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.references :user 
      t.bigint :friend_id 

      t.timestamps
    end
    add_foreign_key :friends, :users, column: :friend_id
  end
end

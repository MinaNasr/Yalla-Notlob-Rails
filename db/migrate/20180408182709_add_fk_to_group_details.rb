class AddFkToGroupDetails < ActiveRecord::Migration[5.1]
  def change
    remove_column :group_details, :userId
    remove_column :group_details, :groupId
    add_column :group_details , :user_id , :bigint
    add_column :group_details , :group_id , :bigint

    add_foreign_key :group_details, :users, column: :user_id
    add_foreign_key :group_details, :groups, column: :group_id
  end
end

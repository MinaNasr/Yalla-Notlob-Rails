class AddFkToGroups < ActiveRecord::Migration[5.1]
  def change
    remove_column :groups, :ownerId
    add_column :groups , :owner_id , :bigint
    add_foreign_key :groups, :users , column: :owner_id
  end
end

class RemoveGroupIdFromGroups < ActiveRecord::Migration[5.1]
  def change
    remove_column :groups, :groupId

  end
end

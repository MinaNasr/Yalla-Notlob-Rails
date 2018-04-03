class CreateGroupDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :group_details do |t|
      t.numeric :groupId
      t.numeric :userId

      t.timestamps
    end
  end
end

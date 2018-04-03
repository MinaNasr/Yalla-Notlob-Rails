class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.numeric :groupId
      t.string :groupName
      t.numeric :ownerId

      t.timestamps
    end
  end
end

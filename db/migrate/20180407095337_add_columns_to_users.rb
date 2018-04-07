class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :profile_id, :string
    add_column :users, :api_token, :string
    add_column :users, :api_type, :string
  end
end

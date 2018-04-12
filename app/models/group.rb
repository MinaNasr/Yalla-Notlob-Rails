class Group < ApplicationRecord
    default_scope { order(created_at: :desc) }

    belongs_to :user,  foreign_key: :owner_id
    has_many :users 
    has_many :group_detail,  dependent: :delete_all
end

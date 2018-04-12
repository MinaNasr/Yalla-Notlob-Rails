class OrderUser < ApplicationRecord
    default_scope { order(created_at: :desc) }

    belongs_to :order
    belongs_to :user
    validates_presence_of :order , :user
end

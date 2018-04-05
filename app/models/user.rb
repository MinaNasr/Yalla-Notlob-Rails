class User < ApplicationRecord
    has_many :groups
    has_many :orders
    has_many :order_details
    has_many :group_details
end

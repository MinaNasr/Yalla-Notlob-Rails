class OrderUser < ApplicationRecord
    belongs_to :order
    belongs_to :user
    validates_presence_of :order , :user
end

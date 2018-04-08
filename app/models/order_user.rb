class OrderUser < ApplicationRecord
    belongs_to :order
    belongs_to :user
    validate_presence_of :order , :user
end

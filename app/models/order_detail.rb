class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :user
  validates_presence_of :order_id, :user_id, :item_name, :price

end

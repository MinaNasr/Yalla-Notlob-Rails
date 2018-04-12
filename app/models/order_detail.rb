class OrderDetail < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :order
  belongs_to :user
  validates_presence_of :order_id, :user_id, :item_name, :price

end

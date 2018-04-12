class OrderDetail < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :order, -> { select(:id, :join) }
  belongs_to :user, -> { select(:id, :name) } 
  validates_presence_of :order_id, :user_id, :item_name, :price

  def as_json(options = {})
    super options.merge(:include => :user)
  end

end

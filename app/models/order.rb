class Order < ApplicationRecord
  default_scope { order(created_at: :desc) }

  enum status: {waiting:"w",finished:"f",canceled:"c"}

  belongs_to :user
  validates_presence_of :meal_name, :image, :restaurant_name


  #validate status enum
  def status=(val)
    super val
  rescue
    @__bad_status_val = val
    super nil
  end
end

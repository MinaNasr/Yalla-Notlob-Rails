class Order < ApplicationRecord
  belongs_to :user

  validates_presence_of :meal_name, :image, :restaurant_name
end

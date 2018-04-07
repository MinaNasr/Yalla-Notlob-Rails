class User < ApplicationRecord

  enum api_type: {facebook:"f",google:"g",website:"w"}

  #Validations
  validates_presence_of :name, :email, :password_digest , :api_type
  validates :email, uniqueness: true

  #validate api_type enum
  def api_type=(val)
    super val
  rescue
    @__bad_api_type_val = val
    super nil
  end

  #encrypt password
  has_secure_password

  has_many :groups
  has_many :orders
  has_many :order_details
  has_many :group_details

end


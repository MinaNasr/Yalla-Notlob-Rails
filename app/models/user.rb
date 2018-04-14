class User < ApplicationRecord

  # attribute  :name


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

  #hide password_digest from json object
  def as_json(options = {})
    super(options.merge({ except: [:password_digest,:created_at,:updated_at,:api_type,:api_token] }))
  end

  #encrypt password
  has_secure_password

  has_many :friends
  # has_many :objects, class_name: "object", foreign_key: "reference_id"
  # belongs_to :user
  has_many :groups,foreign_key: :owner_id
  has_many :groups
  has_many :orders
  has_many :order_details
  has_many :group_details

end


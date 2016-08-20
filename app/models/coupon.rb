class Coupon < ApplicationRecord
  validates_presence_of :valid_until, :code, :quantity, :discount, :discount_type
  has_many :orders
end

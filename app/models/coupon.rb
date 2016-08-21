class Coupon < ApplicationRecord
  validates :valid_until, :code, :quantity, :discount, :discount_type, presence: true
  has_many :orders
end

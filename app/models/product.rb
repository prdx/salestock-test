class Product < ApplicationRecord
  validates :product_name, :quantity, presence: true
  has_many :orderlines
end

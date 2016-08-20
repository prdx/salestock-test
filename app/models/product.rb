class Product < ApplicationRecord
  validates_presence_of :product_name, :quantity
  has_many :orderlines
end

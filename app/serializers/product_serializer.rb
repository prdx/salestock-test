class ProductSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :quantity, :prize
end

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :total_prize, :discounted_total_prize,
    :shipping_id, :shipping_partner, :shipping_status
  has_many :orderlines
end

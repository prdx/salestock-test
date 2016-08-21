class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :name, :phone, :email, :address,
             :total_prize, :discounted_total_prize, :payment_proof,
             :shipping_id, :shipping_partner, :shipping_status
  has_many :orderlines
end

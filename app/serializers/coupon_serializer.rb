class CouponSerializer < ActiveModel::Serializer
  attributes :id, :code, :valid_until, :quantity, :discount, :discount_type
end

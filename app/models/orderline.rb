class Orderline < ApplicationRecord
  validates_presence_of :order_id, :product_id
  validate :product_quantity_cannot_be_zero

  private

  def product_quantity_cannot_be_zero
    if product_id.present?
      product = Product.find(product_id)
      if product.quantity == 0
        errors.add(:product_id, 'Product quantity cannot be zero')
      end
    end
  end

end

class Orderline < ApplicationRecord
  validates_presence_of :order_id, :product_id
  validate :product_quantity_is_not_zero

  before_save :update_order

  private

  def product_quantity_is_not_zero
    if product_id.present?
      begin
        product = Product.find(product_id)
        errors.add(:product_id, 'is not available') if product.quantity == 0
      rescue ActiveRecord::RecordNotFound
        errors.add(:product_id, 'is not available')
      end
    end
  end

  def update_order
    order = Order.find(order_id)
    product = Product.find(product_id)
    order.total_prize += product.prize
    if order.coupon_id
      order.discounted_total_prize = discounted_total_prize(
        order.total_prize,
        order.coupon_id
      )
    end
    order.save!
  rescue ActiveRecord::RecordNotFound
    errors.add(:product_id, 'failed to process')
  end

  def discounted_total_prize(total_prize, coupon_id)
    coupon = Coupon.find(coupon_id)
    case coupon.discount_type
    when 'PERCENT'
      return total_prize - coupon.discount / 100 * total_prize
    when 'NOMINAL'
      return total_prize - coupon.discount
    else
      return 0
    end
  end
end

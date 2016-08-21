class Order < ApplicationRecord
  validates_presence_of :name, :phone, :email, :address
  validate :coupon_exists
  validate :coupon_quantity_is_not_zero
  validate :coupon_is_not_expired

  before_update :check_if_has_orderline
  before_save :update_product_quantity
  before_save :update_coupon_quantity

  has_many :orderlines

  private

  def coupon_exists
    if coupon_id.present?
      begin
        Coupon.find(coupon_id)
      rescue ActiveRecord::RecordNotFound
        errors.add(:coupon_id, 'not found')
      end
    end
  end

  def coupon_quantity_is_not_zero
    if coupon_id.present?
      coupon = Coupon.find(coupon_id)

      errors.add(:coupon_id, 'is not available') if coupon.quantity == 0
    end
  end

  def coupon_is_not_expired
    if coupon_id.present?
      coupon = Coupon.find(coupon_id)

      errors.add(:coupon_id, 'is expired') if coupon.valid_until < Date.today
    end
  end

  def check_if_has_orderline
    if status == 'PAYMENT_PROOF_REQUIRED'
      orderlines = Orderline.where(order_id: self.id)

      if orderlines.count == 0
        self.status = 'INITIATED'
        errors.add(:status, 'input product first')    
      end
    end
  end

  def update_product_quantity
    if status == 'PAYMENT_PROOF_REQUIRED'
      orderlines = Orderline.where(order_id: id)

      orderlines.each do |orderline|
        product = Product.find(orderline.product_id)
        product.quantity -= 1
        product.save!
      end
    elsif status == 'CANCELLED'
      orderlines = Orderline.where(order_id: id)

      orderlines.each do |orderline|
        product = Product.find(orderline.product_id)
        product.quantity += 1
        product.save!
      end
    end
  end

  def update_coupon_quantity
    if status == 'PAYMENT_PROOF_REQUIRED'
      if coupon_id
        coupon = Coupon.find(coupon_id)
        coupon.quantity -= 1
        coupon.save!
      end
    elsif status == 'CANCELLED'
      if coupon_id
        coupon = Coupon.find(coupon_id)
        coupon.quantity += 1
        coupon.save!
      end
    end
  end
end

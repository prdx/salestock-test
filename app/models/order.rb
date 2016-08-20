class Order < ApplicationRecord
  validates_presence_of :name, :phone, :email, :address
  validate :coupon_exists
  validate :coupon_quantity_is_not_zero
  validate :coupon_is_not_expired

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

      if coupon.quantity == 0
        errors.add(:coupon_id, 'is not available')
      end
    end
  end

  def coupon_is_not_expired
    if coupon_id.present?
      coupon = Coupon.find(coupon_id)

      if coupon.valid_until < Date.today
        errors.add(:coupon_id, 'is expired')
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

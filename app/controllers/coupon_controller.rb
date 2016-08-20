class CouponController < ApplicationController
  def index
    coupons = Coupon.all
    render json: coupons, status: 200
  end
end

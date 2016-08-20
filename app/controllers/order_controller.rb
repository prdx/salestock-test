class OrderController < ApplicationController
  def index
    orders = Order.all
    render json: orders, status: 200
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def add_orderline
    @orderline = Orderline.new(orderline_params)

    if @orderline.save
      render json: @orderline, status: :created
    else
      render json: @orderline.errors, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :name,
      :phone,
      :email,
      :address,
      :status,
      :coupon_id
    )
  end

  def orderline_params
    params.require(:orderline).permit(:product_id, :order_id)
  end
end

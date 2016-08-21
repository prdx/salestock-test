class OrderController < ApplicationController
  def index
    orders = Order.all
    render json: orders, status: 200
  end

  def show
    order_id = params[:id]
    begin
      @order = Order.find(order_id)
      render json: @order, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Record not found' }, status: 404
    end
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

  def checkout
    order_id = params[:id]
    @orderlines = Orderline.where(order_id: order_id)

    if @orderlines.count > 0
      @order = Order.find(order_id)
      @order.status = 'PAYMENT_PROOF_REQUIRED'
      if @order.save
        render json: @order, status: :ok
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'Input product first' }, status: :unprocessable_entity
    end
  end

  def search_shipment
    shipping_id = params[:id]
    @order = Order.where(shipping_id: shipping_id).first

    if @order
      render json: @order.shipping_status, status: :ok
    else
      render json: { message: 'Record not found' }, status: 404
    end
  end

  def submit_proof
    order_id = payment_proof_params[:id]
    begin
      @order = Order.find(order_id)
      if @order.status == 'PAYMENT_PROOF_REQUIRED'
        if @order.update(payment_proof_params)
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      else
        render json: { message: 'Order is not valid' }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Record not found' }, status: 404
    end
  end

  def submit_shipment
    order_id = shipment_params[:id]
    begin
      @order = Order.find(order_id)
      if @order.status == 'PAYMENT_PROOF_SUBMITTED'
        if @order.update(shipment_params)
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      else
        render json: { message: 'Order is not valid' }, status: :unprocessable_entity
      end
    rescue
      render json: { message: 'Record not found' }, status: 404
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

  def payment_proof_params
    params.require(:payment_proof)
          .permit(:id, :payment_proof)
          .merge(status: 'PAYMENT_PROOF_SUBMITTED')
  end

  def shipment_params
    params.require(:shipment_info)
          .permit(:id, :shipping_id, :shipping_partner, :shipping_status)
          .merge(status: 'SHIPPED')
  end
end

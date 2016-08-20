require 'rails_helper'

RSpec.describe Orderline, type: :model do
  it 'is valid with valid attributes' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product)
    orderline = Orderline.new(order_id: order.id, product_id: product.id)
    expect(orderline).to be_valid
  end

  it 'is not valid without order' do
    orderline = Orderline.new(order_id: nil)
    expect(orderline).to_not be_valid
  end

  it 'is not valid without product' do
    order = FactoryGirl.create(:order)
    orderline = Orderline.new(order_id: order.id, product_id: nil)
    expect(orderline).to_not be_valid
  end

  it 'is not valid if product quantity is zero' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product, quantity: 0)
    orderline = Orderline.new(order_id: order.id, product_id: product.id)
    expect(orderline).to_not be_valid
  end

end

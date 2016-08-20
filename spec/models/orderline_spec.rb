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

  it 'is not valid if order does not exist' do
    some_random_number = 123_884_214
    orderline = Orderline.new(order_id: some_random_number, product_id: nil)
    expect(orderline).to_not be_valid
  end

  it 'is not valid if product does not exist' do
    some_random_number = 123_884_214
    order = FactoryGirl.create(:order)
    orderline = Orderline.new(order_id: order.id, product_id: some_random_number)
    expect(orderline).to_not be_valid
  end

  it 'is not valid if product quantity is zero' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product, quantity: 0)
    orderline = Orderline.new(order_id: order.id, product_id: product.id)
    expect(orderline).to_not be_valid
  end
end

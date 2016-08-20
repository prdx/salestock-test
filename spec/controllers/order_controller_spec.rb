require 'rails_helper'

RSpec.describe OrderController, type: :controller do
  let(:valid_order) { FactoryGirl.build(:order) }

  it 'sends list of order' do
    get :index
    expect(response).to be_success
  end

  it 'sends created if order is valid' do
    params = { format: :json, :order => { 
      name: valid_order.name,
      phone: valid_order.phone,
      email: valid_order.email,
      address: valid_order.email,
    } }
    post :create, params
    expect(response.status).to eq(201)
  end

  it 'sends unprocessable entity if order is not valid' do
    params = { format: :json, :order => { 
      address: valid_order.email,
    } }
    post :create, params
    expect(response.status).to eq(422)
  end

  it 'sends created after successfully add products' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product)
    params = { format: :json, :orderline => {
      order_id: order.id,
      product_id: product.id,
    } }
    post :add_orderline, params
    expect(response.status).to eq(201)
  end

  it 'sends unprocessable_entity after add product fail' do
    params = { format: :json, :orderline => {
      order_id: nil,
      product_id: nil,
    } }
    post :add_orderline, params
    expect(response.status).to eq(422)
  end
end

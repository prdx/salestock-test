require 'rails_helper'

RSpec.describe OrderController, type: :controller do
  let(:valid_order) { FactoryGirl.build(:order) }

  it 'sends list of order' do
    get :index
    expect(response).to be_success
  end

  it 'sends created if order is valid' do
    params = { format: :json, order: {
      name: valid_order.name,
      phone: valid_order.phone,
      email: valid_order.email,
      address: valid_order.email
    } }
    post :create, params
    expect(response.status).to eq(201)
  end

  it 'sends unprocessable entity if order is not valid' do
    params = { format: :json, order: {
      address: valid_order.email
    } }
    post :create, params
    expect(response.status).to eq(422)
  end

  it 'can put payment proof' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product)
    Orderline.create(order_id: order.id, product_id: product.id)
    order.status = 'PAYMENT_PROOF_REQUIRED'
    order.save

    params = {
      format: :json, payment_proof: {
        id: order.id,
        payment_proof: 'XYZ1234455'
      }
    }

    put :submit_proof, params
    expect(response.status).to eq(200)
  end

  it 'can put shipment data' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product)
    Orderline.create(order_id: order.id, product_id: product.id)
    order.status = 'PAYMENT_PROOF_SUBMITTED'
    order.save

    params = {
      format: :json, shipment_info: {
        id: order.id,
        shipping_id: 'HSHA',
        shipping_partner: 'JNE',
        shipping_status: 'IN PROGRESS'
      }
    }

    put :submit_shipment, params
    expect(response.status).to eq(200)
  end

  it 'can search shipment' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product)
    Orderline.create(order_id: order.id, product_id: product.id)
    order.status = 'SHIPPED'
    order.shipping_id = 'LOREM'
    order.shipping_partner = 'IPSUM'
    order.shipping_status = 'IN PROGRESS'
    order.save

    get :search_shipment, id: order.shipping_id
    expect(response.status).to eq(200)
  end

  it 'can search order' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product)
    Orderline.create(order_id: order.id, product_id: product.id)
    order.status = 'SHIPPED'
    order.shipping_id = 'LOREM'
    order.shipping_partner = 'IPSUM'
    order.shipping_status = 'IN PROGRESS'
    order.save

    get :show, id: order.id
    expect(response.status).to eq(200)
  end

  it 'sends success if checkout is valid' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product)
    Orderline.create(order_id: order.id, product_id: product.id)
    get :checkout, id: order.id
    expect(response.status).to eq(200)
  end

  it 'sends unprocessable_entity if checkout is valid' do
    order = FactoryGirl.create(:order)
    get :checkout, id: order.id
    expect(response.status).to eq(422)
  end

  it 'sends created after successfully add products' do
    order = FactoryGirl.create(:order)
    product = FactoryGirl.create(:product)
    params = { format: :json, orderline: {
      order_id: order.id,
      product_id: product.id
    } }
    post :add_orderline, params
    expect(response.status).to eq(201)
  end

  it 'sends unprocessable_entity after add product fail' do
    params = { format: :json, orderline: {
      order_id: nil,
      product_id: nil
    } }
    post :add_orderline, params
    expect(response.status).to eq(422)
  end
end

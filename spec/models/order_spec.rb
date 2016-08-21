require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'is valid with valid parameters' do
    expect(Order.create(name: 'Bagus',
                        phone: '123',
                        email: 'dummy@mail.com',
                        address: 'dummy')).to be_valid
  end

  it 'has default status INITIATED' do
    order = Order.create
    expect(order.status).to eq('INITIATED')
  end

  it 'is not valid if name does not exist' do
    order = Order.create(name: nil)
    expect(order).to_not be_valid
  end

  it 'is not valid if phone does not exist' do
    order = Order.create(phone: nil)
    expect(order).to_not be_valid
  end

  it 'is not valid if email does not exist' do
    order = Order.create(email: nil)
    expect(order).to_not be_valid
  end

  it 'is not valid if address does not exist' do
    order = Order.create(address: nil)
    expect(order).to_not be_valid
  end

  it 'is not valid if coupon exists but coupon quantity is 0' do
    coupon = FactoryGirl.create(:coupon, quantity: 0)
    order = FactoryGirl.build(:order, coupon_id: coupon.id)
    expect(order).to_not be_valid
  end

  it 'is not valid if coupon exists but coupon is expired' do
    coupon = FactoryGirl.create(:coupon, valid_until: '1990-01-01 00:00')
    order = FactoryGirl.build(:order, coupon_id: coupon.id)
    expect(order).to_not be_valid
  end

  describe 'count the total prize' do
    it 'has default total prize as zero' do
      order = FactoryGirl.create(:order)
      expect(order.total_prize).to eq(0)
    end

    it 'has total prize if it has orderlines' do
      product = FactoryGirl.create(:product)
      order = FactoryGirl.create(:order)
      Orderline.create(order_id: order.id, product_id: product.id)
      expect(order.reload.total_prize).to be > 0
    end

    describe 'has percentage coupon' do
      it 'shows correct discounted prize' do
        product = FactoryGirl.create(:product)
        coupon = FactoryGirl.create(:coupon)
        order = FactoryGirl.create(:order, coupon_id: coupon.id)
        Orderline.create(order_id: order.id, product_id: product.id)
        discount = coupon.discount / 100 * order.reload.total_prize
        expect(order.reload.total_prize).to eq(
          order.reload.discounted_total_prize + discount
        )
      end
    end

    describe 'has nominal coupon' do
      it 'shows correct discounted prize' do
        product = FactoryGirl.create(:product)
        coupon = FactoryGirl.create(
          :coupon,
          discount_type: 'NOMINAL',
          discount: product.prize / 10
        )
        order = FactoryGirl.create(:order, coupon_id: coupon.id)
        Orderline.create(order_id: order.id, product_id: product.id)
        discount = coupon.discount
        expect(order.reload.total_prize).to eq(
          order.reload.discounted_total_prize + discount
        )
      end
    end
  end

  context 'order is valid' do
    it 'changes the status to PAYMENT_PROOF_REQUIRED' do
      product = FactoryGirl.create(:product)
      coupon = FactoryGirl.create(:coupon)
      order = FactoryGirl.create(:order, coupon_id: coupon.id)
      Orderline.create(order_id: order.id, product_id: product.id)

      order.status = 'PAYMENT_PROOF_REQUIRED'
      order.save!
      expect(order.status).to eq('PAYMENT_PROOF_REQUIRED')
    end


    it 'cannot update status PAYMENT_PROOF_REQUIRED if no orderline' do
      order = FactoryGirl.create(:order)
      order.status = 'PAYMENT_PROOF_REQUIRED'
      order.save
      expect(order.reload.status).to eq('INITIATED')
    end

    it 'reduces the quantity of the ordered products' do
      product = FactoryGirl.create(:product)
      coupon = FactoryGirl.create(:coupon)
      order = FactoryGirl.create(:order, coupon_id: coupon.id)
      Orderline.create(order_id: order.id, product_id: product.id)
      previous_product_quantity = product.quantity

      order.status = 'PAYMENT_PROOF_REQUIRED'
      order.save!
      expect(product.reload.quantity).to eq(previous_product_quantity - 1)
    end

    it 'reduces the quantity of the used coupon' do
      coupon = FactoryGirl.create(:coupon)
      order = FactoryGirl.create(:order, coupon_id: coupon.id)
      previous_coupon_quantity = coupon.quantity

      order.status = 'PAYMENT_PROOF_REQUIRED'
      order.save!
      expect(coupon.reload.quantity).to eq(previous_coupon_quantity - 1)
    end
  end

  context 'admin' do
    describe 'cancelled' do
      it 'change the status into CANCELLED' do
        product = FactoryGirl.create(:product)
        coupon = FactoryGirl.create(:coupon)
        order = FactoryGirl.create(:order, coupon_id: coupon.id)
        Orderline.create(order_id: order.id, product_id: product.id)

        order.status = 'CANCELLED'
        order.save!
        expect(order.status).to eq('CANCELLED')
      end

      it 'increase the quantity of the ordered products' do
        product = FactoryGirl.create(:product)
        coupon = FactoryGirl.create(:coupon)
        order = FactoryGirl.create(:order, coupon_id: coupon.id)
        Orderline.create(order_id: order.id, product_id: product.id)

        order.status = 'PAYMENT_PROOF_REQUIRED'
        order.save!

        previous_product_quantity = product.reload.quantity
        order.status = 'CANCELLED'
        order.save!
        expect(product.reload.quantity).to eq(previous_product_quantity + 1)
      end

      it 'increase the quantity of the used coupon' do
        coupon = FactoryGirl.create(:coupon)
        order = FactoryGirl.create(:order, coupon_id: coupon.id)

        order.status = 'PAYMENT_PROOF_REQUIRED'
        order.save!

        previous_coupon_quantity = coupon.reload.quantity
        order.status = 'CANCELLED'
        order.save!

        expect(coupon.reload.quantity).to eq(previous_coupon_quantity + 1)
      end
    end

    it 'can change the status to SHIPPED' do
      product = FactoryGirl.create(:product)
      coupon = FactoryGirl.create(:coupon)
      order = FactoryGirl.create(:order, coupon_id: coupon.id)
      Orderline.create(order_id: order.id, product_id: product.id)

      order.status = 'SHIPPED'
      order.save!
      expect(order.status).to eq('SHIPPED')
    end
  end
end

require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it 'is not valid if valid_until is empty' do
    coupon = FactoryGirl.build(:coupon, valid_until: nil)
    expect(coupon).to_not be_valid
  end

  it 'is not valid if code is empty' do
    coupon = FactoryGirl.build(:coupon, code: nil)
    expect(coupon).to_not be_valid
  end

  it 'is not valid if quantity is empty' do
    coupon = FactoryGirl.build(:coupon, quantity: nil)
    expect(coupon).to_not be_valid
  end

  it 'is not valid if discount is empty' do
    coupon = FactoryGirl.build(:coupon, discount: nil)
    expect(coupon).to_not be_valid
  end

  it 'is not valid if discount_type is empty' do
    coupon = FactoryGirl.build(:coupon, discount_type: nil)
    expect(coupon).to_not be_valid
  end
end
